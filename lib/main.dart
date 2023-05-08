import 'package:faq_app/common/routes.dart';
import 'package:faq_app/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:faq_app/presentation/cubits/faq_cubit/faq_cubit.dart';
import 'package:faq_app/presentation/ui/home_page.dart';
import 'package:faq_app/presentation/ui/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => di.locator(),
        ),
        BlocProvider<FaqCubit>(
          create: (context) => di.locator(),
        ),
      ],
      child: MaterialApp(
        title: 'Faq App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green,
        ),
        initialRoute: AppRoutes.loginRouteName,
        routes: {
          AppRoutes.loginRouteName: (context) => const LoginPage(),
          AppRoutes.homeRouteName: (context) => const HomePage(),
        },
      ),
    );
  }
}
