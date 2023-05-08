import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failures.dart';
import 'package:faq_app/domain/entities/faq.dart';
import 'package:faq_app/domain/repositories/faq_repository.dart';

class GetFaqsUseCase {
  final FaqRepository repository;

  GetFaqsUseCase({required this.repository});

  Future<Either<Failure, List<Faq>>> execute(String tokenType, String token) {
    return repository.getFaqs(tokenType, token);
  }
}
