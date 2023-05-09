import 'package:faq_app/data/datasources/faq_remote_data_source.dart';
import 'package:faq_app/data/model/faq_model.dart';
import 'package:faq_app/data/model/form_faq_model.dart';
import 'package:faq_app/domain/entities/faq.dart';
import 'package:faq_app/domain/entities/form_faq.dart';
import 'package:faq_app/domain/entities/user.dart';
import 'package:faq_app/common/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:faq_app/domain/repositories/faq_repository.dart';

class FaqRepositoryImpl implements FaqRepository {
  final FaqRemoteDataSource remoteDataSource;

  FaqRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final result = await remoteDataSource.login(email, password);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> logout(String token) async {
    try {
      final result = await remoteDataSource.logout(token);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Faq>>> getFaqs(String token, int page) async {
    try {
      final result = await remoteDataSource.getFaqs(token, page);
      return Right(result.map((faq) => faq.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteFaq(String token, Faq faq) async {
    try {
      final result =
          await remoteDataSource.deleteFaq(token, FaqModel.fromEntity(faq));
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> createFaq(
    String token,
    FormFaq formFaq,
  ) async {
    try {
      final result = await remoteDataSource.createFaq(
          token, FormFaqModel.fromEntity(formFaq));
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateFaq(
      String token, FormFaq formFaq, int faqId) async {
    try {
      final result = await remoteDataSource.updateFaq(
        token,
        FormFaqModel.fromEntity(formFaq),
        faqId,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Faq>> getFaq(String token, int faqId) async {
    try {
      final result = await remoteDataSource.getFaq(token, faqId);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
