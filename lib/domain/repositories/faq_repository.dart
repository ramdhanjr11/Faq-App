import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failures.dart';
import 'package:faq_app/domain/entities/user.dart';

abstract class FaqRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, String>> logout(String tokenType, String token);
}
