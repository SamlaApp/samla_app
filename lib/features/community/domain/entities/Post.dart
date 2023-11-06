class Post {
  final String content;
  final int writerID;
  final int? postID;
  final int? communityID;
  final String? imageURL;
  final int? numOfLikes;
  final int? numOfComments;
  final List<String>? likesUserIDs; //who like this post

  Post(this.communityID, 
      {this.postID,
      required this.content,
      required this.writerID,
      this.imageURL,
      required this.numOfLikes,
      required this.numOfComments,
      this.likesUserIDs});
}
