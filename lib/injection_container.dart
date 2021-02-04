import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:microblogging/features/news/presentation/provider/news_manager.dart';

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'features/news/data/datasources/news_data_source.dart';
import 'features/news/data/repositories/news_repository.dart';
import 'features/news/domain/repositories/news_repository.interface.dart';
import 'features/news/domain/usecases/get_news.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => NewsManager(
      getNews: sl(),
    ),
  );

  // Use cases

  sl.registerLazySingleton(() => GetNews(sl()));

  // Repository
  sl.registerLazySingleton<INewsRepository>(
    () => NewsRepository(
      networkInfo: sl(),
      newsDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<INewsDataSource>(
    () => NewsDataSource(dio: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
