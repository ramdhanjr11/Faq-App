import 'package:dio/dio.dart';
import 'package:faq_app/common/exceptions.dart';
import 'package:faq_app/data/model/response_model/login_response.dart';
import 'package:faq_app/data/model/response_model/logout_response.dart';
import 'package:faq_app/data/model/user_model.dart';

abstract class FaqRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<String> logout(String tokenType, String token);
}

class FaqRemoteDataSourceImpl implements FaqRemoteDataSource {
  final Dio dio;
  final baseUrl = 'https://be.lms-staging.madrasahkemenag.com';

  FaqRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await dio.post(
      '$baseUrl/api/v1/auth/login',
      data: {'nip': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final result = response.data;
      return LoginResponse.fromJson(result).data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> logout(String tokenType, String token) async {
    final response = await dio.post(
      '$baseUrl/api/v1/logout',
      data: {'type': tokenType, 'token': token},
    );

    if (response.statusCode == 200) {
      final result = response.data;
      return LogoutResponse.fromJson(result).message;
    } else {
      throw ServerException();
    }
  }
}
