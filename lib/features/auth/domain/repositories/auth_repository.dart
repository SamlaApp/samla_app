import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> getCachedUser();

  Future<Either<Failure, User>> loginWithEmail(
    String email,
    String password,
  );

  Future<Either<Failure, User>> loginWithUsername(
    String username,
    String password,
  );

  Future<Either<Failure, Unit>> loginWithPhoneNumber(String phoneNumber);

  Future<Either<Failure, User>> signup(
    String name,
    String email,
    String username,
    String phone,
    String dateOfBirth,
    String password,
  );

  Future<Either<Failure, User>> sendOTP(String phoneNumber, String otp);

  Future<Either<Failure, Unit>> logout(String token);

  Future<Either<Failure, User>> update(User newUser);

  
}
