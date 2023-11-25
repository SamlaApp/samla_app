import 'package:samla_app/features/community/data/models/Comment.dart';
import 'package:samla_app/features/community/domain/entities/Post.dart';

class PostModel extends Post {
  PostModel(
      {super.writerName,
      super.writerImageURL,
      required super.communityID,
      required super.content,
      required super.writerID,
      required super.numOfLikes,
      super.postID,
      super.imageURL,
      super.imageFile,
      super.likesUserIDs,
      super.numOfComments,
      super.type, required super.date,
      super.comments
      });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    if (json['writer_photo'] != null &&
        !json['writer_photo'].isEmpty &&
        !json['writer_photo'].contains('http')) {
      json['writer_photo'] =
          'https://samla.mohsowa.com/api/user/user_photo/' + json['writer_photo'];
    }
    return PostModel(
      writerName: json['writer_name'],
      writerImageURL: json['writer_photo'],
      postID: json['id'],
      communityID: json['community_id'],
      content: json['message'],
      writerID: json['user_id'],
      numOfLikes: json['likes'],
      imageURL: json['image'] != null
          ? 'https://samla.mohsowa.com/api/community/posts/' + json['image']
          : null,
      type: json['type'],
      numOfComments: json['num_of_comments'],
      date: json['created_at'],
    );
  }

  // from entity to PostModel
  factory PostModel.fromEntity(Post post) {
    return PostModel(
      writerName: post.writerName,
      writerImageURL: post.writerImageURL,
      postID: post.postID,
      communityID: post.communityID,
      content: post.content,
      writerID: post.writerID,
      numOfLikes: post.numOfLikes,
      imageURL: post.imageURL,
      type: post.type,
      numOfComments: post.numOfComments,
      imageFile: post.imageFile,
      date: post.date,
      comments: post.comments
    );
  }

  Map<String, String> toJson() {
    return {
      'id': super.postID.toString(),
      'community_id': super.communityID.toString(),
      'message': super.content ?? '',
      'user_id': super.writerID.toString(),
      'likes': super.numOfLikes.toString(),
      'type': super.type.toString(),
      'image': super.imageURL.toString(),
      'num_of_comments': super.numOfComments.toString(),
      'writer_name':super.writerName.toString(),
      'writer_photo': super.writerImageURL.toString(),
      'created_at': super.date.toString(),
    };
  }
}
