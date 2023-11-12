import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/network/samlaAPI.dart';
// import 'package:samla_app/core/network/samlaAPI_test.dart';
import 'package:samla_app/features/community/data/models/Comment.dart';
import 'package:samla_app/features/community/data/models/Post.dart';
import 'package:samla_app/features/community/domain/entities/Comment.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts(int communityID);
  Future<PostModel> addPost(PostModel postModel);
  Future<void> deletePost(int postID);
  Future<PostModel> updatePost(PostModel postModel);
  Future<void> likePost(int postID);
  Future<void> unlikePost(int postID);
  Future<CommentModel> commentPost(CommentModel comment);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  @override
  Future<PostModel> addPost(PostModel post) async {
    final data = post.toJson();

    http.MultipartFile? multipartFile = null;

    if (post.imageFile != null) {
      multipartFile = http.MultipartFile(
        'image', // The field name in the multipart request
        http.ByteStream(post.imageFile!.openRead()),
        await post.imageFile!.length(),

        filename: 'image.jpg',
        contentType: MediaType('image', 'jpeg'),
      );
    }

    final res = await samlaAPI(
        data: data,
        endPoint: '/community/post/send',
        method: 'POST',
        file: multipartFile);
    final resBody = await res.stream.bytesToString();
    final decodedJson = json.decode(resBody);

    if (res.statusCode == 201) {
      decodedJson['writer_name'] = decodedJson['user']['name'];
      decodedJson['writer_photo'] = decodedJson['user']['photo'];
      return PostModel.fromJson(decodedJson['post']);
    } else {
      throw ServerException(message: decodedJson['message']);
    }
  }

  @override
  Future<CommentModel> commentPost(CommentModel comment) async {
    final data = comment.toJson();
    final res = await samlaAPI(
      data: data,
      endPoint: '/community/comment/send',
      method: 'POST',
    );
    final resBody = await res.stream.bytesToString();
    final decodedJson = json.decode(resBody);

    if (res.statusCode == 201) {
      decodedJson['comment']['writer_name'] = decodedJson['comment']['user']['name'];
      decodedJson['comment']['writer_photo'] = decodedJson['comment']['user']['photo'];
      return CommentModel.fromJson(decodedJson['comment']);
    } else {
      throw ServerException(message: decodedJson['message']);
    }
  }

  @override
  Future<void> deletePost(int postID) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getAllPosts(int communityID) async {
    final res = await samlaAPI(
        endPoint: '/community/post/get/$communityID', method: 'GET');

    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      final decodedJson = json.decode(resBody);
      
      final posts = decodedJson['posts'].map<PostModel>((post) {
        post['writer_name'] = post['user']['name'];
        post['writer_photo'] = post['user']['photo'];
        final postModel = PostModel.fromJson(post);
        print(post['comments']);
        final comments = post['comments'] != null
            ? _getCommentsFromJson(post)
            : null;
        postModel.comments = comments ?? [];
        return postModel;
      }).toList();
      return posts;
    } else {
      final decodedJson = json.decode(resBody);
      throw ServerException(message: decodedJson['message']);
    }
  }

  List<CommentModel> _getCommentsFromJson(Map<String, dynamic> json) {
    final comments = json['comments'].map<CommentModel>((comment) {
      comment['writer_name'] = comment['user']['name'];
      comment['writer_photo'] = comment['user']['photo'];
      return CommentModel.fromJson(comment);
    }).toList();
    return comments;
  }

  @override
  Future<void> likePost(int postID) {
    // TODO: implement likePost
    throw UnimplementedError();
  }

  @override
  Future<void> unlikePost(int postID) {
    // TODO: implement unlikePost
    throw UnimplementedError();
  }

  @override
  Future<PostModel> updatePost(PostModel postModel) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}

main() async {
  try {
    // testing getAllPosts
    final postRemoteDataSource = PostRemoteDataSourceImpl();
    final posts = await postRemoteDataSource.getAllPosts(11);
    print(posts[0].writerName);
    // testing addPost
    final post = PostModel(
        date: '2012-1-2',
        communityID: 23,
        content: 'second post',
        writerID: 2,
        type: 'text',
        numOfLikes: 2);
    // final addedPost = await postRemoteDataSource.addPost(post);
    // print(addedPost);

    // testing commentPost
    final comment = CommentModel(
        communityID: 11,
        content: 'second post',
        postID: 1,
        writerID: 2,
        writerName: 'mohamed',
        date: '2012-1-2');

    final addedComment = await postRemoteDataSource.commentPost(comment);
    print(addedComment.toJson().toString());
  } on ServerException catch (e) {
    print(e.message);
  }
}
