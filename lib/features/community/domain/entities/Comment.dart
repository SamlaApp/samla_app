import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String content;
  final String postID;
  final int? id;
  final String writerName;
  final String writerID;

  const Comment(
      {required this.content, required this.postID, required this.id
      , required this.writerName, required this.writerID});

  @override
  // TODO: implement props
  List<Object?> get props => [content, postID, id];
}
