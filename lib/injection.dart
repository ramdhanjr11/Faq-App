import 'package:dio/dio.dart';
import 'package:faq_app/data/datasources/faq_remote_data_source.dart';
import 'package:faq_app/data/repository/faq_repository_impl.dart';
import 'package:faq_app/domain/repositories/faq_repository.dart';
import 'package:faq_app/domain/usecases/login_usecase.dart';
import 'package:faq_app/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // data
  locator.registerLazySingleton<FaqRemoteDataSource>(
    () => FaqRemoteDataSourceImpl(
      dio: locator(),
    ),
  );

  // repository
  locator.registerLazySingleton<FaqRepository>(
    () => FaqRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // usecases
  locator.registerLazySingleton(
    () => LoginUseCase(
      repository: locator(),
    ),
  );

  // cubits
  locator.registerFactory(
    () => AuthCubit(
      locator(),
    ),
  );

  // external
  locator.registerLazySingleton<Dio>(() => Dio());
}
