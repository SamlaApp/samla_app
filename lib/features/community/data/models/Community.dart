import 'package:samla_app/features/community/domain/entities/Community.dart';

class CommunityModel extends Community {
  CommunityModel(
      {required super.name,
      required super.description,
      required super.isPublic,
      required super.handle,
      required super.numOfMemebers,
      super.avatar,
      super.id,
      super.imageURL});

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
        name: json['name'],
        description: json['description'],
        isPublic: json['isPublic'],
        handle: json['handle'],
        numOfMemebers: json['numOfMemebers'],
        id: json['id'],
        imageURL: json['imageURL']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': super.name,
      'description': super.description,
      'isPublic': super.isPublic ? '1' : '0',
      'handle': super.handle,
      'numOfMemebers': super.numOfMemebers,
      'id': super.id,
      'imageURL': super.imageURL
    };
  }

// used when create a new community
  factory CommunityModel.fromEntity(Community community) {
    return CommunityModel(
      name: community.name,
      description: community.description,
      isPublic: community.isPublic,
      handle: community.handle,
      numOfMemebers: community.numOfMemebers,
      avatar: community.avatar,
    );
  }
}

