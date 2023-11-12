import 'dart:io';

import 'package:samla_app/features/community/domain/entities/Comment.dart';

class Post {
  final String? content;
  final int writerID;
  final String? type;
  final int? postID;
  final int communityID;
  final String? imageURL;
  final int? numOfLikes;
  final File? imageFile;
  final int? numOfComments;
  final List<String>? likesUserIDs;
  final String? writerName;
  final String? writerImageURL;
  final String? date;
  List<Comment> comments;

  Post( 
      {this.date,this.writerName,
      this.writerImageURL,
      this.postID,
      required this.communityID,
      this.content,
      required this.writerID,
      required this.type,
      this.imageURL,
      required this.numOfLikes,
      this.imageFile,
      this.numOfComments,
      this.likesUserIDs,
      this.comments = const[],
      });
}
