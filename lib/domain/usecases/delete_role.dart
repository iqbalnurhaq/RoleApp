import 'package:dartz/dartz.dart';
import 'package:roleapp/data/models/role_model.dart';
import 'package:roleapp/domain/repositories/role_repository.dart';
import 'package:roleapp/shared/failure.dart';

class DeleteRole {
  final RoleRepository repository;

  DeleteRole(this.repository);

  Future<Either<Failure, bool>> execute(String id) {
    return repository.deleteRole(id);
  }
}
