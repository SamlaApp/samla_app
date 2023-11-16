import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/core/network/samlaAPI.dart';
import 'package:samla_app/features/auth/data/models/user_model.dart';
import 'package:samla_app/features/community/data/models/RequestToJoin.dart';

abstract class CommunityAdminRemoteDataSource {
  Future<List<RequestToJoin>> getJoinRequests({required int communityID});

  Future<void> acceptJoinRequest(int communityID, int userID);

  Future<void> rejectJoinRequest(
      int communityID, int userID);

  Future<void> deleteUser(int communityID, int userID);
}

class CommunityAdminRemoteDataSourceImpl
    implements CommunityAdminRemoteDataSource {
  @override
  Future<List<RequestToJoin>> getJoinRequests(
      {required int communityID}) async {
    final res = await samlaAPI(
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
  Future<void> rejectJoinRequest(
   int communityID, int userID) async{
     final data = {
      'community_id': communityID.toString(),
      'user_id': userID.toString(),
      'accepted': '0',
    };
    final res = await samlaAPI(
        data: data,
        endPoint: '/community/accept_join_request/',
        method: 'POST');

    final resBody = await res.stream.bytesToString();
    final decodedJson = json.decode(resBody);
    if (res.statusCode != 200) {
      throw ServerException(message: decodedJson['message']);
    }
  }

  @override
  Future<void> acceptJoinRequest(int communityID, int userID) async {
    final data = {
      'community_id': communityID.toString(),
      'user_id': userID.toString(),
      'accepted': '1',
    };
    final res = await samlaAPI(
        data: data,
        endPoint: '/community/accept_join_request/',
        method: 'POST');

    final resBody = await res.stream.bytesToString();
    final decodedJson = json.decode(resBody);
    if (res.statusCode != 200) {
      throw ServerException(message: decodedJson['message']);
    }
  }

  @override
  Future<void> deleteUser(int communityID, int userID) async {
    final data = {
      'community_id': communityID.toString(),
      'user_id': userID.toString(),
    };
    final res = await samlaAPI(
        data: data, endPoint: '/community/delete_member', method: 'POST');
    final resBody = await res.stream.bytesToString();
    final decodedJson = json.decode(resBody);
    if (res.statusCode != 200) {
      throw ServerException(message: decodedJson['message']);
    }
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
