import 'dart:convert';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/community/data/models/Community.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart'; // Import MediaType
import 'package:samla_app/core/network/samlaAPI.dart';
import 'package:samla_app/main.dart';

abstract class CommunityRemoteDataSource {
  Future<List<CommunityModel>> getAllCommunities();

  Future<List<List<CommunityModel>>> getMyCommunities();

  Future<CommunityModel> createCommunity(Community community);

  Future<CommunityModel> updateCommunity(CommunityModel community);

  Future<void> deleteCommunity({required int communityID});

  Future<void> joinCommunity({required int communityID});

  Future<void> leaveCommunity({required int communityID});

  Future<int> getCommunityMemebersNumber({required int communityID});
}

const BASE_URL = 'https://samla.mohsowa.com/api/community';

class CommunityRemoteDataSourceImpl implements CommunityRemoteDataSource {
  final http.Client client;
  

  CommunityRemoteDataSourceImpl({required this.client});

  @override
  Future<void> deleteCommunity({required int communityID}) async {
    final res =
        await _request(endPoint: '/delete/$communityID', method: 'DELETE');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode != 200) {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<List<CommunityModel>> getAllCommunities() async {
    final res = await _request(endPoint: '/get_all', method: 'GET');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      final communitiesJsonList = json.decode(resBody)['communities'];
      final List<CommunityModel> communities = [];
      communitiesJsonList.forEach((community) {
        // if the already a member of the community
        if (!community['is_member']) {

          if (community['avatar'] != null) {
            community['avatar'] =
                BASE_URL + '/community_avatar/' + community['avatar'];
          }
          communities.add(CommunityModel.fromJson(community));
        }
      });
      return communities;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<List<List<CommunityModel>>> getMyCommunities() async {
    final res = await _request(endPoint: '/get', method: 'GET');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      final communitiesJsonList = json.decode(resBody)['communities'];
      final List<CommunityModel> communities = [];
      final List<CommunityModel> requestedCommunities = [];

      communitiesJsonList.forEach((communityRequest) {
        // if the already a member of the community
        if (communityRequest['community'] == null) {
          communityRequest['is_member'] = true;

          if (communityRequest['avatar'] != null) {
            communityRequest['avatar'] =
                BASE_URL + '/community_avatar/' + communityRequest['avatar'];
          }
          communities.add(CommunityModel.fromJson(communityRequest));
        }
        // if the community is public or the request is accepted
        else if (communityRequest['community']['is_public'] == 1 ||
            communityRequest['accepted'] == 1) {
          // since API will not provide is_member field for getMyCommunities
          communityRequest['community']['is_member'] = true;
          if (communityRequest['community']['avatar'] != null) {
            communityRequest['community']['avatar'] = BASE_URL +
                '/community_avatar/' +
                communityRequest['community']['avatar'];
          }
          communities
              .add(CommunityModel.fromJson(communityRequest['community']));
        } else {
          communityRequest['community']['is_member'] = false;

          requestedCommunities
              .add(CommunityModel.fromJson(communityRequest['community']));
        }
      });
      return [communities, requestedCommunities];
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<void> joinCommunity({required int communityID}) async {
    final data = {
      'community_id': communityID.toString(),
    };
    final res = await _request(data: data, endPoint: '/join', method: 'POST');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode != 200 && res.statusCode != 201) {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<void> leaveCommunity({required int communityID}) async {
    final data = {
      'community_id': communityID.toString(),
    };
    final res = await _request(data: data, endPoint: '/leave', method: 'POST');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode != 200) {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<CommunityModel> updateCommunity(CommunityModel community) {
    // TODO: implement updateCommunity
    throw UnimplementedError();
  }

  @override
  Future<CommunityModel> createCommunity(Community community_) async {
    final community = CommunityModel.fromEntity(community_);
    http.MultipartFile? multipartFile = null;

    if (community.avatar != null) {
      multipartFile = http.MultipartFile(
        'avatar', // The field name in the multipart request
        http.ByteStream(community.avatar!.openRead()),
        await community.avatar!.length(),
        filename: 'avatar.jpg',
        contentType: MediaType('image', 'jpeg'),
      );
    }


    final response = await _request(
        data: community.toJson(),
        endPoint: '/create',
        method: 'POST',
        file: multipartFile);
    final resBody = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      final communityJson = json.decode(resBody)['community'];
      communityJson['is_member'] = true;
      if (communityJson['avatar'] != null) {
        communityJson['avatar'] =
            BASE_URL + '/community_avatar/' + communityJson['avatar'];
      }
      final community = CommunityModel.fromJson(communityJson);
      return community;
    } else {
      print(resBody);
      print(json.decode(resBody)['message']);
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  // Future<http.StreamedResponse> _request(
  //     {Map<String, String>? data,
  //     http.MultipartFile? file,
  //     required String endPoint,
  //     required String method}) async {
  //   final token = sl.get<AuthBloc>().user.accessToken;
  //   // final token =
  //   // 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWM1MmY3MzE4YTU4ZGM0YTk0N2ZhNzNmMDE3MDA2ZWFkNDBiYWI5YjYxNDFkYTg4ZmVmMGNjNzI0YjQ0ZTQ0ZjA5OTQxYjI0ZTA1NzdiMWIiLCJpYXQiOjE2OTgyNzA2MzQuMjcwOTg2LCJuYmYiOjE2OTgyNzA2MzQuMjcwOTksImV4cCI6MTcyOTg5MzAzNC4yNjExNywic3ViIjoiMiIsInNjb3BlcyI6W119.XLyod1nGrbfBwN1QOPo1ns5gIo9qPiPwGXtw_nzlJjL6ZjNiijTPPQUEwV5ffrWARfefq0o956AZKexEyVP5ngYWx39R9mo6NSWi1pvbZVJ0Jy8mJR2MeFCkNcYbKrlSSWZsWVl3UYJg3H_INSJOxgSGcRBaIrQQBUF-HsGWSO8rX5rLTfUYB76au3-JEEB4O_68MDKHs1skoaAlLxX3VRvRV9DcL1beGLAN9h0jjZRP7oByOMKUZl_oj1__QmcYC_XtvaKCflWZrfNYQ2bm1WVsmTvdPfxrS6g7lakBZjUFPWbYZfhjK9ZCu5pvngfDB1DwyJ899VPZmi0AqaiBAES6VC78hF_Eci26wQsCexeGCTOl1di8iSSdVa3sUe5QynjS0VF-DJ1EVBlFxY59N9z-KFy89Zkz-OHsplR2SujZIgyGq3QsIEDxz0Qr9iWJau6DaO3U9h-ZuEFm56Ugs6nIVfXzXOqg4C45mfFZFmWnmw96PRE1myfKJc6wwSn07I5uSL9WQzTC-zUU77HzhrGUiP5hjNxmwTTXIZ-8FKpI3me0jmMgG_RT46RcIyqxXyQXV42ZohXVmPGsWC4ZOfg4brEfJaM_tale8GwXqASKKN3OnirNWHjqkUvki_wRtK5jfbDzanKNoqwPe2puqry1npE2vGeLv0GnzJHujEE';

  //   var headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //   var request = http.MultipartRequest(method, Uri.parse(BASE_URL + endPoint));

  //   if (data != null) {
  //     request.fields.addAll(data);
  //   }

  //   if (file != null) {
  //     request.files.add(file);
  //   }

  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await client.send(request);
  //   // print('hello, world');
  //   return response;
  // }


Future<http.StreamedResponse> _request(
      {Map<String, String>? data,
      http.MultipartFile? file,
      required String endPoint,
      required String method,
      bool autoLogout = true}) async {
    final token = authBloc.user.accessToken;
    // final token = 'random';
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest(method, Uri.parse(BASE_URL + endPoint));

    if (data != null) {
      request.fields.addAll(data);
    }

    if (file != null) {
      request.files.add(file);
    }

    request.headers.addAll(headers);


    http.StreamedResponse response = await client.send(request);
    if (response.statusCode == 401) {
      if (autoLogout) {
        authBloc.add(LogOutEvent(navigatorKey.currentState!.context));
      } else {
        throw UnauthorizedException();
      }
    } else {
      return response;
    }
    return response;
  }

  

  @override
  Future<int> getCommunityMemebersNumber({required int communityID}) async {
    final res = await _request(
        endPoint: '/get_total_members/$communityID', method: 'GET');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      final membersNumber = json.decode(resBody)['total_members'];
      return membersNumber;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }
}

// test
void main() async {
  try {
    final client = http.Client();
    final remoteDataSource = CommunityRemoteDataSourceImpl(client: client);

    // testing getAllCommunities
    final communities = await remoteDataSource.getAllCommunities();
    print(communities[0].name);

    // testing getMyCommunities
    final [myCommunities, reqestedCommunities] =
        await remoteDataSource.getMyCommunities();
    print(myCommunities[0].name);
    // print(reqestedCommunities[0].name);

    //testing joinCommunity
    await remoteDataSource.joinCommunity(communityID: 1);
  } on ServerException catch (e) {
    print(e.message);
  } catch (e) {
    print(e.toString());
  }
}
