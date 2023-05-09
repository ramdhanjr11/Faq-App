import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failures.dart';
import 'package:faq_app/domain/entities/faq.dart';
import 'package:faq_app/domain/repositories/faq_repository.dart';

class GetFaqUseCase {
  final FaqRepository repository;

  const GetFaqUseCase({required this.repository});

  Future<Either<Failure, Faq>> execute(String token, int faqId) {
    return repository.getFaq(token, faqId);
  }
}
