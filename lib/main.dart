import 'package:faq_app/common/routes.dart';
import 'package:faq_app/ui/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faq App',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.loginRouteName,
      routes: {
        AppRoutes.loginRouteName: (context) => const LoginPage(),
      },
    );
  }
}
