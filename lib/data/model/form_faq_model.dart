// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:faq_app/domain/entities/form_faq.dart';

class FormFaqModel extends Equatable {
  final int? faqId;
  final String question;
  final String answer;
  final bool publishStatus;

  const FormFaqModel({
    this.faqId,
    required this.question,
    required this.answer,
    required this.publishStatus,
  });

  factory FormFaqModel.fromEntity(FormFaq formFaq) {
    return FormFaqModel(
      faqId: formFaq.faqId,
      question: formFaq.question!,
      answer: formFaq.answer!,
      publishStatus: formFaq.publishStatus!,
    );
  }

  Map<String, dynamic> toJson() => {
        'pertanyaan': question,
        'jawaban': answer,
        'status_publish': publishStatus,
      };

  @override
  List<Object> get props => [question, answer, publishStatus];
}
