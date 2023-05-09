// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FormFaq extends Equatable {
  final bool isEditable;
  final int? faqId;
  final String? question;
  final String? answer;
  final bool? publishStatus;

  const FormFaq({
    required this.isEditable,
    this.faqId,
    this.question,
    this.answer,
    this.publishStatus,
  });

  @override
  List<Object> get props => [isEditable];
}
