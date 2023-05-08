// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:faq_app/data/model/faq_model.dart';

class FaqsResponse extends Equatable {
  final int code;
  final String message;
  final List<FaqModel> faqs;

  const FaqsResponse({
    required this.code,
    required this.message,
    required this.faqs,
  });

  factory FaqsResponse.fromJson(Map<String, dynamic> json) {
    return FaqsResponse(
        code: json['code'],
        message: json['message'],
        faqs: List.from(json['data'])
            .map((data) => FaqModel.fromJson(data))
            .toList());
  }

  @override
  List<Object> get props => [code, message, faqs];
}
