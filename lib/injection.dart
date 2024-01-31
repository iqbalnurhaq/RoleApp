import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:roleapp/data/datasources/auth_remote_data_source.dart';
import 'package:roleapp/data/repositories/auth_repository_impl.dart';
import 'package:roleapp/domain/repositories/auth_repository.dart';
import 'package:roleapp/domain/usecases/login.dart';
import 'package:roleapp/presentation/provider/auth_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(() => AuthNotifier(
        login: locator(),
      ));

  //use case
  locator.registerLazySingleton(() => Login(locator()));

  // repository
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: locator()),
  );

  // http
  locator.registerLazySingleton(() => http.Client());
}
