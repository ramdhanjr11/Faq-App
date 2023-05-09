// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:faq_app/domain/entities/faq.dart';

class FaqModel extends Equatable {
  final int id;
  final String question;
  final String answer;
  final int publishStatus;
  final String createdAt;
  final String updatedAt;

  const FaqModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.publishStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['id'],
      question: json['pertanyaan'],
      answer: json['jawaban'],
      publishStatus: json['status_publish'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  factory FaqModel.fromEntity(Faq faq) {
    return FaqModel(
      id: faq.id,
      question: faq.question,
      answer: faq.answer,
      publishStatus: faq.publishStatus,
      createdAt: faq.createdAt,
      updatedAt: faq.updatedAt,
    );
  }

  Faq toEntity() => Faq(
        id: id,
        question: question,
        answer: answer,
        publishStatus: publishStatus,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

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
