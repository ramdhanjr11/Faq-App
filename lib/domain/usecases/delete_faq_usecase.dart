import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failures.dart';
import 'package:faq_app/domain/entities/faq.dart';
import 'package:faq_app/domain/repositories/faq_repository.dart';

class DeleteFaqUseCase {
  final FaqRepository repository;

  DeleteFaqUseCase({required this.repository});

  Future<Either<Failure, String>> execute(
    String token,
    Faq faq,
  ) {
    return repository.deleteFaq(token, faq);
  }
}
