import 'package:faq_app/common/routes.dart';
import 'package:faq_app/presentation/cubits/auth_cubit/auth_cubit.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Welcome to FAQ App',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4),
                const Text('Please login with your account..'),
                const SizedBox(height: 64),
                Text(
                  'Email',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                FormBuilderTextField(
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
                const SizedBox(height: 16),
                Text(
                  'Password',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                FormBuilderTextField(
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
                const SizedBox(height: 16),
                SizedBox(
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
                          setState(() {
                            _isLoading = true;
                          });
                        }
                        if (state is LoginError) {
                          setState(() {
                            _isLoading = false;
                          });
                          _showSnackbar(state.message);
                        }
                        if (state is LoginSuccess) {
                          setState(() {
                            _isLoading = false;
                          });
                          _showSnackbar('Login Successfuly');
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.homeRouteName,
                          );
                        }
                      },
                      child: Visibility(
                        visible: _isLoading,
                        replacement: const Text('Login'),
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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

  _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}