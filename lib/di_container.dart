import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wbs_app/cubit/laporan/laporan_cubit.dart';
import 'package:wbs_app/data/datasource/remote/dio/logging_interceptor.dart';
import 'package:wbs_app/data/datasource/remote/dio/dio_client.dart';
import 'package:wbs_app/cubit/auth/auth_cubit.dart';
import 'package:wbs_app/data/repository/auth_repo.dart';
import 'package:wbs_app/data/repository/laporan_repo.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  await dotenv.load(fileName: '.env');

  // External
  final sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => LoggingInterceptor());

  // Core
  getIt.registerLazySingleton(
    () => DioClient(dotenv.env['BASE_API_URL']!, getIt(),
        loggingInterceptor: getIt(), sharedPreferences: getIt()),
  );

  // Repository
  getIt.registerLazySingleton(
    () => AuthRepo(dioClient: getIt(), sharedPreferences: getIt()),
  );
  getIt.registerLazySingleton(
    () => LaporanRepo(dioClient: getIt(), sharedPreferences: getIt()),
  );

  // cubit
  getIt.registerFactory<AuthCubit>(
      () => AuthCubit(authRepo: getIt(), sharedPreferences: getIt()));
  getIt.registerFactory<LaporanCubit>(() => LaporanCubit(laporanRepo: getIt()));
}
