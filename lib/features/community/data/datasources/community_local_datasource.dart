import 'dart:convert';

import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/community/data/models/Community.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CommunityLocalDataSource {
  Future<void> cacheCommunities(List<CommunityModel> communities);

  Future<List<CommunityModel>> getCachedCommunities();
}

class CommunityLocalDataSourceImpl implements CommunityLocalDataSource {
  final SharedPreferences sharedPreferences;

  CommunityLocalDataSourceImpl(this.sharedPreferences);
  @override
  Future<List<CommunityModel>> getCachedCommunities() {
    final jsonCommunitiesString = sharedPreferences.getString('my_communities');
    if (jsonCommunitiesString != null) {
         final jsonCommunities = json.decode(jsonCommunitiesString);

      // decode the json list to list of community models
      final communities = jsonCommunities
          .map<CommunityModel>(
              (community) => CommunityModel.fromJson(community))
          .toList();
      return Future.value(communities);
    } else {
      throw EmptyCacheException(message: 'No cached communities');
    }
  }

  @override
  Future<void> cacheCommunities(List<CommunityModel> communities) {
    final jsonCommunities = jsonEncode(communities);
    sharedPreferences.setString('my_communities', jsonCommunities);
    return Future.value();
  }
}
