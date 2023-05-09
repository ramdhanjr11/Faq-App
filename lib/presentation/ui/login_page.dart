import 'package:faq_app/common/routes.dart';
import 'package:faq_app/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:faq_app/utils/show_snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isVisible = true;
  bool _isLoading = false;

  void _setPasswordVisible() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  _setLoadingState(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_isLoading) const LinearProgressIndicator(),
              const SizedBox(height: 16),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                child: Text(
                  'Welcome to FAQ App',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text('Please login with your account..'),
              ),
              const SizedBox(height: 64),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Text(
                  'Email',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: FormBuilderTextField(
                  name: "email",
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'example@gmail.com',
                    prefixIcon: Icon(Icons.email),
                    prefixIconColor: Colors.grey,
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Text(
                  'Password',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: FormBuilderTextField(
                  name: 'password',
                  obscureText: _isVisible,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'password',
                    prefixIcon: const Icon(Icons.key),
                    prefixIconColor: Colors.grey,
                    suffixIcon: IconButton(
                      onPressed: () => _setPasswordVisible(),
                      icon: _isVisible
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    suffixIconColor: Colors.grey,
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(
                      5,
                      errorText: '5 characters minimum',
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.saveAndValidate()) {
                      _processLogin(_formKey.currentState!.value);
                    }
                  },
                  child: BlocListener<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is LoginLoading) {
                        _setLoadingState(true);
                      }
                      if (state is LoginError) {
                        _setLoadingState(false);
                        showSnackbar(state.message, context);
                      }
                      if (state is LoginSuccess) {
                        _setLoadingState(false);
                        showSnackbar('Login Successfuly', context);
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.homeRouteName,
                        );
                      }
                    },
                    child: const Text('Login'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _processLogin(Map<String, dynamic> valueForm) {
    final email = valueForm['email'];
    final password = valueForm['password'];
    context.read<AuthCubit>().login(email, password);
  }
}
