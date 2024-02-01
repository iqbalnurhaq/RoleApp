import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:roleapp/data/datasources/auth_remote_data_source.dart';
import 'package:roleapp/domain/repositories/auth_repository.dart';
import 'package:roleapp/shared/failure.dart';
import 'package:roleapp/shared/shared_preference.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  SharedPref sharedPref = SharedPref();

  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, bool>> login(Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.login(body);
      if (result.status) {
        await sharedPref.saveString("token", result.data.token.accessToken);
        return Right(true);
      } else {
        return Left(ConnectionFailure(''));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }
}
