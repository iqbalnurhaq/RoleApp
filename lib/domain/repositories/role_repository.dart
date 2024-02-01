import 'package:dartz/dartz.dart';
import 'package:roleapp/data/models/role_model.dart';
import 'package:roleapp/shared/failure.dart';

abstract class RoleRepository {
  Future<Either<Failure, List<RoleModel>>> getAllRole();
  Future<Either<Failure, RoleModel>> addRole(Map<String, dynamic> body);
  Future<Either<Failure, RoleModel>> editRole(
      Map<String, dynamic> body, String id);
  Future<Either<Failure, bool>> deleteRole(String id);
}
