class Post {
  final String title;
  final String content;
  final String writerID;
  final String? postID;
  final String? imageURL;
  final int? numOfLikes;
  final int? numOfComments;
  final List<String>? likesUserIDs; //who like this post

  Post(
      {this.postID,
      required this.title,
      required this.content,
      required this.writerID,
      this.imageURL,
      required this.numOfLikes,
      required this.numOfComments,
      this.likesUserIDs});
}
