import 'package:faq_app/presentation/ui/detail_page.dart';
import 'package:faq_app/presentation/ui/form_faq_page.dart';
import 'package:faq_app/presentation/ui/home_page.dart';
import 'package:faq_app/presentation/ui/login_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const loginRouteName = '/login_page';
  static const homeRouteName = '/home_page';
  static const detailRouteName = '/detail_page';
  static const formFaqRouteName = '/form_faq_page';

  static final routeObserver = RouteObserver<ModalRoute>();

  static final routes = {
    loginRouteName: (context) => const LoginPage(),
    homeRouteName: (context) => const HomePage(),
    detailRouteName: (context) => const DetailPage(),
    formFaqRouteName: (context) => const FormFaqPage(),
  };
}
