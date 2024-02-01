import 'package:dartz/dartz.dart';
import 'package:roleapp/data/models/role_model.dart';
import 'package:roleapp/domain/repositories/role_repository.dart';
import 'package:roleapp/shared/failure.dart';

class AddRole {
  final RoleRepository repository;

  AddRole(this.repository);

  Future<Either<Failure, RoleModel>> execute(Map<String, dynamic> body) {
    return repository.addRole(body);
  }
}
