import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failures.dart';
import 'package:faq_app/domain/repositories/faq_repository.dart';

class LogoutUseCase {
  final FaqRepository repository;

  const LogoutUseCase({required this.repository});

  Future<Either<Failure, String>> execute(String token) {
    return repository.logout(token);
  }
}
