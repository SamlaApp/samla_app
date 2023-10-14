import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/auth/domain/repositories/auth_repository.dart';

class CheckOTP {
  final AuthRepository repository;

  CheckOTP({required this.repository});

  Future<Either<Failure, User>> call(
    String phoneNumber,
    String otp,
  ) {
    return repository.sendOTP(phoneNumber,otp );
  }
}
