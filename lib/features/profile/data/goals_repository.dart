import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/core/network/network_info.dart';
import 'package:samla_app/core/network/samlaAPI.dart';
import 'package:samla_app/features/auth/data/models/user_model.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/profile/domain/Goals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

enum Gender { male, female }

class GoalsRepository {
  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;

  GoalsRepository(this.networkInfo, this.sharedPreferences);

  Future<Either<Failure, User>> setGender(String gender) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await samlaAPI(
            data: {"gender": gender},
            endPoint: '/goals/update_gender',
            method: 'POST');
        final resBody = json.decode(await res.stream.bytesToString());

        if (res.statusCode != 200) {
          return Left(ServerFailure(message: resBody['message']));
        }
        return Right(UserModel.fromJson(resBody['user']));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: 'Something went wrong'));
      }
    } else {
      return Left(ServerFailure(message: 'No Internet Connection'));
    }
  }

  Future<Either<Failure, User>> setHeight(double height) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await samlaAPI(
            data: {"height": height.toString()},
            endPoint: '/goals/update_height',
            method: 'POST');
        final resBody = json.decode(await res.stream.bytesToString());
        if (res.statusCode != 200) {
          return Left(ServerFailure(message: resBody['message']));
        }
        return Right(UserModel.fromJson(resBody['user']));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: 'Something went wrong'));
      }
    } else {
      return Left(ServerFailure(message: 'No Internet Connection'));
    }
  }

  // set wightTarget
  Future<Either<Failure, UserGoals>> setWeightTarget(
      double weightTarget) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await samlaAPI(
            data: {"weight_target": weightTarget.toString()},
            endPoint: '/goals/update_weight_target',
            method: 'POST');
        final resBodyString = await res.stream.bytesToString();

        final resBody = json.decode(resBodyString);

        if (res.statusCode != 200) {
          return Left(ServerFailure(message: resBody['message']));
        }
        return Right(UserGoals.fromJson(resBody['user_goals']));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: 'Something went wrong'));
      }
    } else {
      return Left(ServerFailure(message: 'No Internet Connection'));
    }
  }

  // set steps target
  Future<Either<Failure, UserGoals>> setStepsTarget(int stepsTarget) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await samlaAPI(
            data: {"steps_target": stepsTarget.toString()},
            endPoint: '/goals/update_steps_target',
            method: 'POST');
        final resBody = json.decode(await res.stream.bytesToString());
        if (res.statusCode != 200) {
          return Left(ServerFailure(message: resBody['message']));
        }
        return Right(UserGoals.fromJson(resBody['user_goals']));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: 'Something went wrong'));
      }
    } else {
      return Left(ServerFailure(message: 'No Internet Connection'));
    }
  }

  // set calories target
  Future<Either<Failure, UserGoals>> setCaloriesTarget(
      int caloriesTarget) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await samlaAPI(
            data: {"calories_target": caloriesTarget.toString()},
            endPoint: '/goals/update_calories_target',
            method: 'POST');
        final resBody = json.decode(await res.stream.bytesToString());
        if (res.statusCode != 200) {
          return Left(ServerFailure(message: resBody['message']));
        }
        return Right(UserGoals.fromJson(resBody['user_goals']));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: 'Something went wrong'));
      }
    } else {
      return Left(ServerFailure(message: 'No Internet Connection'));
    }
  }

  // get user goals
  Future<Either<Failure, UserGoals>> getUserGoals() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await samlaAPI(endPoint: '/goals/get_goals', method: 'GET');
        final resBody = json.decode(await res.stream.bytesToString());
        if (res.statusCode != 200) {
          return Left(ServerFailure(message: resBody['message']));
        }
        await setCachedUserGoals(UserGoals.fromJson(resBody['user_goals']));
        return Right(UserGoals.fromJson(resBody['user_goals']));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: 'Something went wrong'));
      }
    } else {
      return getCachedUserGoals();
    }
  }

  // get cached user goals
  Either<Failure, UserGoals> getCachedUserGoals() {
    try {
      final userGoals = sharedPreferences.getString('user_goals');
      if (userGoals != null) {
        return Right(UserGoals.fromJson(json.decode(userGoals)));
      } else {
        return Left(CacheFailure(message: 'No cached user goals'));
      }
    } catch (e) {
      return Left(CacheFailure(message: 'Something went wrong'));
    }
  }

  // set cached user goals

  Future<Either<Failure, Unit>> setCachedUserGoals(UserGoals userGoals) async {
    try {
      final success = await sharedPreferences.setString(
          'user_goals', json.encode(userGoals.toJson()));
      if (!success) {
        return Left(CacheFailure(message: 'Something went wrong'));
      }
      return Right(unit);
    } catch (e) {
      return Left(CacheFailure(message: 'Something went wrong'));
    }
  }

  // check if user has goals
  Future<Either<Failure, Unit>> finishSetGoals() async {
    if (await networkInfo.isConnected) {
      try {
        final res =
            await samlaAPI(endPoint: '/goals/finish_set_goals', method: 'POST');
        final resBody = json.decode(await res.stream.bytesToString());
        if (res.statusCode != 200) {
          return Left(ServerFailure(message: resBody['message']));
        }

        return Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: 'Something went wrong'));
      }
    } else {
      return Left(ServerFailure(message: 'No Internet Connection'));
    }
  }

  // updateAvatar
  Future<Either<Failure, User>> updateAvatar(File image) async {
    if (await networkInfo.isConnected) {
      try {
        http.MultipartFile? multipartFile = null;

        if (image != null) {
          multipartFile = http.MultipartFile(
            'photo',
            http.ByteStream(image.openRead()),
            await image.length(),
            filename: 'image.jpg',
            contentType: MediaType('image', 'jpeg'),
          );
        }

        final res = await samlaAPI(
            endPoint: '/user/update_photo',
            method: 'POST',
            file: multipartFile);

        final resBody = json.decode(await res.stream.bytesToString());
        print(resBody);
        if (res.statusCode != 200) {
          return Left(ServerFailure(message: resBody['message']));
        }
        return Right(UserModel.fromJson(resBody['user']));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: 'Something went wrong'));
      }
    } else {
      return Left(ServerFailure(message: 'No Internet Connection'));
    }
  }

  Future<Either<Failure, User>> updateUserSetting(User user) async {
    if (await networkInfo.isConnected) {
      try {
        print('im heeereee');
        print(user);
        http.MultipartFile? multipartFile = null;
        final data = UserModel.fromEntity(user).toJson();
        final res = await samlaAPI(
            data: data,
            endPoint: '/user/update_profile',
            method: 'POST',
            file: multipartFile);

        final resBody = json.decode(await res.stream.bytesToString());
        print(resBody);
        if (res.statusCode != 200) {
          return Left(ServerFailure(message: resBody['message']));
        }
        return Right(UserModel.fromJson(resBody['user']));
      } on ServerException catch (e) {
        print(e.message);
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: 'Something went wrong'));
      }
    } else {
      return Left(ServerFailure(message: 'No Internet Connection'));
    }
  }

}
