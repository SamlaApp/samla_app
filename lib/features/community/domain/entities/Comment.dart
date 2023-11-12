import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String content;
  final int postID;
  final int communityID;
  final int? id;
  final String? writerName;
  final int? writerID;
  final String? date;
  final String? writerImageURL;

  Comment( 
      {this.writerImageURL,required this.content,
      required this.postID,
      required this.communityID,
      this.id,
      required this.writerName,
      required this.writerID,
      this.date});

  @override
  // TODO: implement props
  List<Object?> get props => [content, postID, id];
}
