import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/community/data/models/RequestToJoin.dart';

abstract class CommunityAdminRepository {

  Future<Either<Failure, List<RequestToJoin>>> getJoinRequests({required int communityID});

  Future<Either<Failure, Unit>> acceptJoinRequest({required int communityID, required int userID});

  Future<Either<Failure, Unit>> rejectJoinRequest({required int communityID, required int userID});

  Future<Either<Failure, Unit>> deleteUser({required int communityID, required int userID});

  

}