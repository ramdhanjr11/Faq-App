import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failures.dart';
import 'package:faq_app/domain/entities/user.dart';
import 'package:faq_app/domain/repositories/faq_repository.dart';

class LoginUseCase {
  final FaqRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, User>> execute(String email, String password) {
    return repository.login(email, password);
  }
}
