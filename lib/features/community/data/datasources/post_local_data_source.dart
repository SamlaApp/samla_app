import 'dart:convert';

import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/community/data/models/Post.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<void> cachePosts(List<PostModel> posts, int communityID);

  Future<List<PostModel>> getCachedPosts(int communityID);
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl(this.sharedPreferences);
  @override
  Future<List<PostModel>> getCachedPosts(int communityID) {
    final jsonPostsString = sharedPreferences.getString('community/$communityID/posts');
    if (jsonPostsString != null) {
      final jsonPosts = json.decode(jsonPostsString);

      // decode the json list to list of posts models
      final posts = jsonPosts
          .map<PostModel>(
              (post) => PostModel.fromJson(post))
          .toList();
      return Future.value(posts);
    } else {
      throw EmptyCacheException(message: 'No cached posts');
    }
  }

  @override
  Future<void> cachePosts(List<PostModel> posts,int communityID) {
    final jsonPosts = jsonEncode(posts);
    sharedPreferences.setString('community/$communityID/posts', jsonPosts);
    return Future.value();
  }
}
