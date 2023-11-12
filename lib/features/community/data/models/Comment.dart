import 'package:samla_app/features/community/domain/entities/Comment.dart';

class CommentModel extends Comment {
  
  CommentModel(
      {super.id,
      required super.communityID,
      required super.content,
      required super.postID,
      required super.writerID,
      required super.writerName,
      super.writerImageURL,
      super.date});
  

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      communityID: json['community_id'],
      content: json['comment'],
      postID: json['post_id'],
      writerID: json['user_id'],
      writerName: json['writer_name'],
      date: json['created_at'],
      writerImageURL: json['writer_photo'],
    );
  }

  factory CommentModel.fromEntity(Comment comment) {
    return CommentModel(
      id: comment.id,
      communityID: comment.communityID,
      content: comment.content,
      postID: comment.postID,
      writerID: comment.writerID,
      writerName: comment.writerName,
      date: comment.date,
      writerImageURL: comment.writerImageURL,
    );
  }

  Map<String, String> toJson() {
    return {
      'community_id': communityID.toString(),
      'comment': content,
      'post_id': postID.toString(),
      'id': id.toString(),
      'writer_name': writerName ?? '',
      'user_id': writerID.toString(),
      'date': date ?? '',
      'writer_photo': writerImageURL ?? '',
    };
  }
}
