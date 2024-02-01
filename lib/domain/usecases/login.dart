import 'package:dartz/dartz.dart';
import 'package:roleapp/domain/repositories/auth_repository.dart';
import 'package:roleapp/shared/failure.dart';

class Login {
  final AuthRepository repository;

  Login(this.repository);

  Future<Either<Failure, bool>> execute(Map<String, dynamic> body) {
    return repository.login(body);
  }
}
