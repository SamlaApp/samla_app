import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/core/network/network_info.dart';
import 'package:samla_app/features/auth/data/datasources/local_data_source.dart';
import 'package:samla_app/features/auth/data/datasources/remote_data_source.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, User>> signup(
      String name,
      String email,
      String username,
      String phone,
      String dateOfBirth,
      String password) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.signup(
            name: name,
            email: email,
            username: username,
            phone: phone,
            dateOfBirth: dateOfBirth,
            password: password);
        //cache user
        await localDataSource.cacheUser(user);
        return Right(user);
      } on ServerException catch (e) {
        return Left(ServerFailure(message:e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmail(
      String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.loginWithEmail(email, password);
        //cache user
        await localDataSource.cacheUser(user);
        return Right(user);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> loginWithPhoneNumber(String phoneNumber) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.loginWithPhoneNumber(phoneNumber);
        return Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, User>> loginWithUsername(
      String username, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final user =
            await remoteDataSource.loginWithUsername(username, password);
        //cache user
        await localDataSource.cacheUser(user);
        return Right(user);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, User>> sendOTP(String phoneNumber, String otp) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.sendOTP(phoneNumber, otp);
        //cache user
        await localDataSource.cacheUser(user);
        return Right(user);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
  
  @override
  Future<Either<Failure, User>> getCachedUser() async {
    try {
      final user = await localDataSource.getCachedUser();
      return Right(user);
    } on EmptyCacheException catch (e) {
      return Left(EmptyCacheFailure(message: e.message));
    }
  }
}
