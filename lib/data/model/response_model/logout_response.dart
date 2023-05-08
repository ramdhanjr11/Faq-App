// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class LogoutResponse extends Equatable {
  final int code;
  final String message;

  const LogoutResponse({
    required this.code,
    required this.message,
  });

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(code: json['code'], message: json['message']);
  }

  @override
  List<Object> get props => [code, message];
}
