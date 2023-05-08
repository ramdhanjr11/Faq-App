import 'package:faq_app/common/routes.dart';
import 'package:faq_app/domain/entities/user.dart';
import 'package:faq_app/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:faq_app/utils/show_snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User user;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    user = context.read<AuthCubit>().user!;
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
          'Home Page',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context
                  .read<AuthCubit>()
                  .logout(user.tokenType, user.accessToken);
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LogoutLoading) {
            _setLoadingState(true);
          }

          if (state is LogoutError) {
            _setLoadingState(false);
            showSnackbar(state.message, context);
          }

          if (state is LogoutSuccess) {
            _setLoadingState(false);
            showSnackbar(state.message, context);
            Navigator.pushReplacementNamed(context, AppRoutes.loginRouteName);
          }
        },
        builder: (context, state) {
          if (_isLoading) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(user.pathPhoto),
                      ),
                      const SizedBox(width: 12),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Welcome, ',
                            ),
                            TextSpan(
                              text: user.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
