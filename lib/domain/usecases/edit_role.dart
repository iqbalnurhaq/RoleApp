import 'package:dartz/dartz.dart';
import 'package:roleapp/data/models/role_model.dart';
import 'package:roleapp/domain/repositories/role_repository.dart';
import 'package:roleapp/shared/failure.dart';

class EditRole {
  final RoleRepository repository;

  EditRole(this.repository);

  Future<Either<Failure, RoleModel>> execute(
      Map<String, dynamic> body, String id) {
    return repository.editRole(body, id);
  }
}
