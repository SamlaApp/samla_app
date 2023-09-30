import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/auth/domain/repositories/auth_repository.dart';

class LoginWithPhoneNumber {
  final AuthRepository repository;

  LoginWithPhoneNumber({required this.repository});

  Future<Either<Failure, Unit>> call(
    String phoneNumber,
  ) {
    return repository.loginWithPhoneNumber(phoneNumber);
  }
}
