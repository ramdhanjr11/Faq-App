import 'package:dio/dio.dart';
import 'package:faq_app/data/datasources/faq_remote_data_source.dart';
import 'package:faq_app/data/repository/faq_repository_impl.dart';
import 'package:faq_app/domain/repositories/faq_repository.dart';
import 'package:faq_app/domain/usecases/delete_faq_usecase.dart';
import 'package:faq_app/domain/usecases/get_faqs_usecase.dart';
import 'package:faq_app/domain/usecases/login_usecase.dart';
import 'package:faq_app/domain/usecases/logout_usecase.dart';
import 'package:faq_app/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:faq_app/presentation/cubits/faq_cubit/faq_cubit.dart';
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

  locator.registerLazySingleton(
    () => LogoutUseCase(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetFaqsUseCase(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => DeleteFaqUseCase(
      repository: locator(),
    ),
  );

  // cubits
  locator.registerFactory(
    () => AuthCubit(
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => FaqCubit(
      locator(),
      locator(),
    ),
  );

  // external
  locator.registerLazySingleton<Dio>(() => Dio());
}
