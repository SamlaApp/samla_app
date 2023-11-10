import 'dart:convert';

import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/community/data/models/Post.dart';
import 'package:samla_app/features/community/domain/entities/Post.dart';

void main(List<String> args) async {
  Post post = Post(
      communityID: 122,
      content: 'hey guys',
      writerID: 2,
      type: 'image',
      numOfLikes: 2,
      postID: 1,
      imageURL: 'https://samla.mohsowa.com/api/community/posts/1',
      numOfComments: 2,
      likesUserIDs: ['1', '2'],
      writerName: 'mohamed',
      writerImageURL: 'https://samla.mohsowa.com/api/community/posts/1',
      );

  final post1 = PostModel.fromEntity(post) ;
  final postJson = json.encode(post1.toJson());
  print('encoded json:\n');
  print(postJson);
  print('decoded json\n');
  final decodedJson = json.decode(postJson);
  final post2 = PostModel.fromJson(decodedJson);
  print(post2.toString());
  // final post2 = PostModel.fromJson());
  // print('decoded json:\n');
  // print(post2.toString());

}

String cachePosts(List<PostModel> posts, int communityID) {
  final jsonPosts = jsonEncode(posts);
  return jsonPosts;
}

List<PostModel> getCachedPosts(int communityID, String jsonc) {
  final jsonPostsString = jsonc;
  if (jsonPostsString != null) {
    final jsonPosts = json.decode(jsonPostsString);
    // decode the json list to list of posts models
    final posts =
        jsonPosts.map<PostModel>((post) => PostModel.fromJson(post)).toList();
    return posts;
  } else {
    throw EmptyCacheException(message: 'No cached posts');
  }
}
