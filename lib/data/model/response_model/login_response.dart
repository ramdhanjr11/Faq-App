// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:faq_app/data/model/user_model.dart';

class LoginResponse extends Equatable {
  final int code;
  final String message;
  final UserModel data;

  const LoginResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      code: json['code'],
      message: json['message'],
      data: UserModel.fromJson(
        json['data'],
      ),
    );
  }

  @override
  List<Object> get props => [code, message, data];
}
