import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/auth/domain/repositories/auth_repository.dart';

class GetCachedUser{
    final AuthRepository repository;

  GetCachedUser({required this.repository});

  Future<Either<Failure, User>> call() {
    return repository.getCachedUser();
  }
}