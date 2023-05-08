import 'package:faq_app/data/datasources/faq_remote_data_source.dart';
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
}
