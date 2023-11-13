import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';

abstract class CommunityAdminRepository {

  Future<Either<Failure, Unit>> getJoinRequests({required int communityID});

  Future<Either<Failure, Unit>> acceptJoinRequest({required int communityID, required int userID});

  Future<Either<Failure, Unit>> rejectJoinRequest({required int communityID, required int userID});

}