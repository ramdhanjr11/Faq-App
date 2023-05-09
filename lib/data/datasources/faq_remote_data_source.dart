import 'package:dio/dio.dart';
import 'package:faq_app/common/exceptions.dart';
import 'package:faq_app/data/model/faq_model.dart';
import 'package:faq_app/data/model/form_faq_model.dart';
import 'package:faq_app/data/model/response_model/faq_response.dart';
import 'package:faq_app/data/model/response_model/faqs_response.dart';
import 'package:faq_app/data/model/response_model/login_response.dart';
import 'package:faq_app/data/model/response_model/logout_response.dart';
import 'package:faq_app/data/model/user_model.dart';

abstract class FaqRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<String> logout(String token);
  Future<List<FaqModel>> getFaqs(String token, int page);
  Future<String> deleteFaq(String token, FaqModel faq);
  Future<String> createFaq(String token, FormFaqModel formFaqModel);
  Future<String> updateFaq(String token, FormFaqModel formFaqModel, int faqId);
  Future<FaqModel> getFaq(String token, int faqId);
}

Options options(String token) {
  return Options(
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
  );
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
  Future<String> logout(String token) async {
    final response = await dio.post(
      '$baseUrl/api/v1/logout',
      options: options(token),
    );

    if (response.statusCode == 200) {
      final result = response.data;
      return LogoutResponse.fromJson(result).message;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<FaqModel>> getFaqs(String token, int page) async {
    final response = await dio.get('$baseUrl/api/v1/superadmin/faq',
        options: options(token), queryParameters: {'page': page});

    if (response.statusCode == 200) {
      final result = response.data;
      return FaqsResponse.fromJson(result).faqs;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> deleteFaq(String token, FaqModel faq) async {
    final response = await dio.delete(
      '$baseUrl/api/v1/superadmin/faq/${faq.id}',
      options: options(token),
    );

    if (response.statusCode == 200) {
      final result = response.data;
      return FaqResponse.fromJson(result).message;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> createFaq(String token, FormFaqModel formFaqModel) async {
    final response = await dio.post(
      '$baseUrl/api/v1/superadmin/faq',
      options: options(token),
      data: formFaqModel.toJson(),
    );

    if (response.statusCode == 200) {
      final result = response.data;
      return FaqResponse.fromJson(result).message;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> updateFaq(
    String token,
    FormFaqModel formFaqModel,
    int faqId,
  ) async {
    final response = await dio.post(
      '$baseUrl/api/v1/superadmin/faq/$faqId',
      options: options(token),
      data: formFaqModel.toJson(),
    );

    if (response.statusCode == 200) {
      final result = response.data;
      return FaqResponse.fromJson(result).message;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<FaqModel> getFaq(String token, int faqId) async {
    final response = await dio.get(
      '$baseUrl/api/v1/superadmin/faq/$faqId',
      options: options(token),
    );

    if (response.statusCode == 200) {
      final result = response.data;
      return FaqResponse.fromJsonGetFaq(result).faq!;
    } else {
      throw ServerException();
    }
  }
}
