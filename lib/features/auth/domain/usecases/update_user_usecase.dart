import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/auth/domain/repositories/auth_repository.dart';

class UpdateUsecase {
  final AuthRepository repository;

  UpdateUsecase({required this.repository});

  Future<Either<Failure, User>> call(
      {String? name,
      String? email,
      String? username,
      String? phone,
      String? dateOfBirth,
      String? password,
      required User currentUser}) async {
    User newUser = User(
      id: currentUser.id,
      accessToken: currentUser.accessToken,
      name: name ?? currentUser.name,
      email: email ?? currentUser.email,
      username: username ?? currentUser.username,
      phone: phone ?? currentUser.phone,
      dateOfBirth: dateOfBirth ?? currentUser.dateOfBirth,
    );
    return repository.update(newUser);
  }
}
