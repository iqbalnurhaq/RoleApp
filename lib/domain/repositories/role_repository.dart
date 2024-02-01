import 'package:dartz/dartz.dart';
import 'package:roleapp/data/models/role_model.dart';
import 'package:roleapp/shared/failure.dart';

abstract class RoleRepository {
  Future<Either<Failure, List<RoleModel>>> getAllRole();
}
