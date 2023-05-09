// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:faq_app/data/model/faq_model.dart';

class FaqResponse extends Equatable {
  final int code;
  final String message;
  final FaqModel? faq;

  const FaqResponse({
    required this.code,
    required this.message,
    this.faq,
  });

  factory FaqResponse.fromJsonDelete(Map<String, dynamic> json) {
    return FaqResponse(code: json['code'], message: json['message']);
  }

  factory FaqResponse.fromJsonUpdate(Map<String, dynamic> json) {
    return FaqResponse(
      code: json['code'],
      message: json['message'],
      faq: FaqModel.fromJson(json['data']),
    );
  }

  @override
  List<Object> get props => [code, message];
}
