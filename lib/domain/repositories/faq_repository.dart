import 'package:dartz/dartz.dart';
import 'package:faq_app/common/failures.dart';
import 'package:faq_app/domain/entities/faq.dart';
import 'package:faq_app/domain/entities/form_faq.dart';
import 'package:faq_app/domain/entities/user.dart';

abstract class FaqRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, String>> logout(String token);
  Future<Either<Failure, List<Faq>>> getFaqs(String token, int page);
  Future<Either<Failure, String>> deleteFaq(String token, Faq faq);
  Future<Either<Failure, String>> createFaq(String token, FormFaq formFaq);
}
