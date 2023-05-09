// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:faq_app/domain/entities/faq.dart';
import 'package:faq_app/domain/entities/user.dart';

class DetailArguments {
  final User user;
  final Faq faq;

  DetailArguments({
    required this.user,
    required this.faq,
  });
}
