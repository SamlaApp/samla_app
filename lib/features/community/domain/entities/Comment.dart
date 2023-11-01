import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String content;
  final String postID;
  final int? id;
  final String? writerName;
  final String? writerID;

// when you send a comment to the server, you don't need to send the id
  const Comment.toSend({this.id, this.writerName, this.writerID, 
      required this.content, required this.postID});

  const Comment.toShow(
      {required this.content, required this.postID, required this.id
      , required this.writerName, required this.writerID});

  @override
  // TODO: implement props
  List<Object?> get props => [content, postID, id];
}
