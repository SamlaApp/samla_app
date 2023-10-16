import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String content;
  final String postID;
  final int? id;

  const Comment({required this.content, required this.postID, required this.id});
  
  @override
  // TODO: implement props
  List<Object?> get props => [content, postID, id];
}
