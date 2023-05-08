// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Faq extends Equatable {
  final int id;
  final String question;
  final String answer;
  final int publishStatus;
  final String createdAt;
  final String updatedAt;

  const Faq({
    required this.id,
    required this.question,
    required this.answer,
    required this.publishStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      question,
      answer,
      publishStatus,
      createdAt,
      updatedAt,
    ];
  }
}
