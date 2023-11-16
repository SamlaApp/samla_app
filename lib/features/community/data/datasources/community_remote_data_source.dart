import 'dart:convert';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/auth/data/models/user_model.dart';
import 'package:samla_app/features/community/data/models/Community.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart'; // Import MediaType
import 'package:samla_app/core/network/samlaAPI.dart';
import 'package:samla_app/features/community/presentation/pages/communities.dart';

abstract class CommunityRemoteDataSource {
  Future<List<CommunityModel>> getAllCommunities();

  Future<List<List<CommunityModel>>> getMyCommunities();

  Future<CommunityModel> createCommunity(Community community);

  Future<CommunityModel> updateCommunity(CommunityModel community);

  Future<void> deleteCommunity({required int communityID});

  Future<void> joinCommunity({required int communityID});

  Future<void> leaveCommunity({required int communityID});

  Future<int> getCommunityMemebersNumber({required int communityID});

  Future<List<CommunityModel>> searchCommunities(String query);

  Future<List<UserModel>> getCommunityMemebers(int communityID, bool isPublic);
}

const BASE_URL = 'https://samla.mohsowa.com/api/community';

class CommunityRemoteDataSourceImpl implements CommunityRemoteDataSource {
  final http.Client client;

  CommunityRemoteDataSourceImpl({required this.client});

  @override
  Future<void> deleteCommunity({required int communityID}) async {
    final res = await samlaAPI(
        endPoint: '/community/delete/$communityID', method: 'DELETE');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode != 200) {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<List<CommunityModel>> getAllCommunities() async {
    final res = await samlaAPI(endPoint: '/community/get_all', method: 'GET');
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
    final res = await samlaAPI(endPoint: '/community/get', method: 'GET');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      final communitiesJsonList = json.decode(resBody)['communities'];
      final List<CommunityModel> communities = [];
      final List<CommunityModel> requestedCommunities = [];

      communitiesJsonList.forEach((communityRequest) {
        // if user is the creator of the community
        if (communityRequest['community'] == null &&
            communityRequest['handle'] != null) {
          communityRequest['is_member'] = true;

          if (communityRequest['avatar'] != null) {
            communityRequest['avatar'] =
                BASE_URL + '/community_avatar/' + communityRequest['avatar'];
          }
          communities.add(CommunityModel.fromJson(communityRequest));
        } else
        // if community is deleted
        if (communityRequest['handle'] == null &&
            communityRequest['community'] == null) {
          // do nothing
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
          if (communityRequest['accepted'] == 0 &&
              communityRequest['rejected'] == 0) {
            requestedCommunities.add(CommunityModel.fromJson(
                communityRequest['community'], RequestType.pending));
          } else if (communityRequest['accepted'] == 0 &&
              communityRequest['rejected'] == 1) {
            requestedCommunities.add(CommunityModel.fromJson(
                communityRequest['community'], RequestType.rejected));
          }
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
    final res =
        await samlaAPI(data: data, endPoint: '/community/join', method: 'POST');
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
    final res = await samlaAPI(
        data: data, endPoint: '/community/leave', method: 'POST');
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

    final response = await samlaAPI(
        data: community.toJson(),
        endPoint: '/community/create',
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

  @override
  Future<int> getCommunityMemebersNumber({required int communityID}) async {
    final res = await samlaAPI(
        endPoint: '/community/get_total_members/$communityID', method: 'GET');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      final membersNumber = json.decode(resBody)['total_members'];
      return membersNumber;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<List<CommunityModel>> searchCommunities(String query) async {
    final res =
        await samlaAPI(endPoint: '/community/search/$query', method: 'GET');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      final communitiesJsonList = json.decode(resBody)['communities'];
      final List<CommunityModel> communities = [];
      communitiesJsonList.forEach((community) {
        if (community['avatar'] != null) {
          community['avatar'] =
              BASE_URL + '/community_avatar/' + community['avatar'];
        }
        communities.add(CommunityModel.fromJson(community));
      });
      return communities;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<List<UserModel>> getCommunityMemebers(
      int communityID, bool isPublic) async {
    final endpoint = isPublic
        ? '/community/get_public_community_members/$communityID'
        : '/community/get_private_community_members/$communityID';
    final res = await samlaAPI(endPoint: endpoint, method: 'GET');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      final membersJsonList = json.decode(resBody)['members'];
      final List<UserModel> members = [];
      membersJsonList.forEach((member) {
        members.add(UserModel.fromJson(member['user']));
      });
      return members;
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
