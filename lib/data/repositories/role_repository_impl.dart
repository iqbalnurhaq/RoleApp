import 'package:dartz/dartz.dart';
import 'package:roleapp/data/datasources/role_remote_data_source.dart';
import 'package:roleapp/data/models/role_model.dart';
import 'package:roleapp/domain/repositories/role_repository.dart';
import 'package:roleapp/shared/failure.dart';

class RoleRepositoryImpl implements RoleRepository {
  final RoleRemoteDataSource remoteDataSource;

  RoleRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<RoleModel>>> getAllRole() async {
    try {
      final result = await remoteDataSource.getAllRole();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }
}