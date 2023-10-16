import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/auth/domain/repositories/auth_repository.dart';

class LoginWithEmail {
  final AuthRepository repository;

  LoginWithEmail({required this.repository});

  Future<Either<Failure, User>> call(
    String email,
    String password,
  )async{
    
    return await repository.loginWithEmail(email, password);
  }

}
