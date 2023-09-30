import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/auth/domain/repositories/auth_repository.dart';

class Signup{
  final AuthRepository repository;

  Signup({required this.repository});
  
  Future<Either<Failure,User>> call(
    String name,
    String email,
    String username,
    String phone,
    String dateOfBirth,
    String password,
  ){
    return repository.signup(
      name,
      email,
      username,
      phone,
      dateOfBirth,
      password,
    );
  }
}