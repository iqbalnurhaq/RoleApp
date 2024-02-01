import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:roleapp/data/datasources/auth_remote_data_source.dart';
import 'package:roleapp/data/datasources/role_remote_data_source.dart';
import 'package:roleapp/data/repositories/auth_repository_impl.dart';
import 'package:roleapp/data/repositories/role_repository_impl.dart';
import 'package:roleapp/domain/repositories/auth_repository.dart';
import 'package:roleapp/domain/repositories/role_repository.dart';
import 'package:roleapp/domain/usecases/add_role.dart';
import 'package:roleapp/domain/usecases/get_all_role.dart';
import 'package:roleapp/domain/usecases/login.dart';
import 'package:roleapp/presentation/provider/auth_notifier.dart';
import 'package:roleapp/presentation/provider/home_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(() => AuthNotifier(
        login: locator(),
      ));
  locator.registerFactory(() => HomeNotifier(
        getAllRole: locator(),
        addRole: locator(),
      ));

  //use case
  locator.registerLazySingleton(() => Login(locator()));
  locator.registerLazySingleton(() => GetAllRole(locator()));
  locator.registerLazySingleton(() => AddRole(locator()));
  // repository
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<RoleRepository>(
    () => RoleRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<RoleRemoteDataSource>(
      () => RoleRemoteDataSourceImpl(client: locator()));

  // http
  locator.registerLazySingleton(() => http.Client());
}
