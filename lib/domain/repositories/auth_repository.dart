import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:roleapp/shared/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> login(Map<String, dynamic> body);
}
