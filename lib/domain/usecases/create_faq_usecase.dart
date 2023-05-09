import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failures.dart';
import 'package:faq_app/domain/entities/form_faq.dart';
import 'package:faq_app/domain/repositories/faq_repository.dart';

class CreateFaqUseCase {
  final FaqRepository repository;

  const CreateFaqUseCase({required this.repository});

  Future<Either<Failure, String>> execute(String token, FormFaq formFaq) {
    return repository.createFaq(token, formFaq);
  }
}
