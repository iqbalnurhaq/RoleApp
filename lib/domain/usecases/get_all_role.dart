import 'package:dartz/dartz.dart';
import 'package:roleapp/data/models/role_model.dart';
import 'package:roleapp/domain/repositories/auth_repository.dart';
import 'package:roleapp/domain/repositories/role_repository.dart';
import 'package:roleapp/shared/failure.dart';

class GetAllRole {
  final RoleRepository repository;

  GetAllRole(this.repository);

  Future<Either<Failure, List<RoleModel>>> execute() {
    return repository.getAllRole();
  }
}
