import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/auth/domain/repositories/auth_repository.dart';

class UpdateUsecase {
  final AuthRepository repository;

  UpdateUsecase({required this.repository});

  Future<Either<Failure, User>> call(User newUser) async {
    return repository.update(newUser);
  }
}
