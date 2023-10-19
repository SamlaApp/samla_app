import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/auth/domain/repositories/auth_repository.dart';

class LogOutUsecase{
  final AuthRepository repository;

  LogOutUsecase({required this.repository});

  Future<Either<Failure, Unit>> call({ required String token}) async {
    return await repository.logout(token);
  }
  
}