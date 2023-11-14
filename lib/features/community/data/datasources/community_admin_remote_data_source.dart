import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/core/network/samlaAPI_test.dart';
import 'package:samla_app/features/auth/data/models/user_model.dart';
import 'package:samla_app/features/community/data/models/RequestToJoin.dart';

abstract class CommunityAdminRemoteDataSource {
  Future<List<RequestToJoin>> getJoinRequests(
      {required int communityID});

  Future<Either<Failure, Unit>> acceptJoinRequest(
      {required int communityID, required int userID});

  Future<Either<Failure, Unit>> rejectJoinRequest(
      {required int communityID, required int userID});
}

class CommunityAdminRemoteDataSourceImpl
    implements CommunityAdminRemoteDataSource {
  @override
  Future<List<RequestToJoin>> getJoinRequests(
      {required int communityID}) async {
    final res = await samlaAPItest(
        endPoint: '/community/get_join_requests/$communityID', method: 'GET');
    final resBody = await res.stream.bytesToString();
    final decodedJson = json.decode(resBody);
    if (res.statusCode == 200) {
      final List<RequestToJoin> requests = [];
      for (var request in decodedJson['join_requests']) {
        requests.add(RequestToJoin.fromJson(
            request, UserModel.fromJson(request['user'])));
      }
      return requests;
    } else {
      throw ServerException(message: decodedJson['message']);
    }
  }

  @override
  Future<Either<Failure, Unit>> rejectJoinRequest(
      {required int communityID, required int userID}) {
    // TODO: implement rejectJoinRequest
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> acceptJoinRequest(
      {required int communityID, required int userID}) {
    // TODO: implement acceptJoinRequest
    throw UnimplementedError();
  }
}

void main(List<String> args) async {
  try {
    final remoteDataSource = CommunityAdminRemoteDataSourceImpl();
    print('created');
    final requests = await remoteDataSource.getJoinRequests(communityID: 9);
    
    print(requests[1].user.name);
  } on ServerException catch (e) {
    print(e.message);
  } on Exception catch (e) {
    print(e.toString());
  }
}
