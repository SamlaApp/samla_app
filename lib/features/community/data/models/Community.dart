import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/presentation/pages/communities.dart';

class CommunityModel extends Community {
  CommunityModel(
      {required super.name,
      required super.description,
      required super.isPublic,
      required super.handle,
      required super.numOfMemebers,
      super.avatar,
      super.id,
      super.imageURL,
      required super.isMemeber,
      super.requestType,
      required super.ownerID});

  factory CommunityModel.fromJson(Map<String, dynamic> json, [RequestType requestType = RequestType.accepted]) {
    return CommunityModel(
        name: json['name'],
        description: json['description'],
        isPublic: json['is_public'] == 1 ? true : false,
        handle: json['handle'],
        id: json['id'],
        imageURL: json['avatar'],
        isMemeber: json['is_member'] ?? false,
        numOfMemebers: 0,
        requestType: requestType,
        ownerID: json['owner_id']);
  }

  Map<String, String> toJson() {
    return {
      'name': super.name,
      'description': super.description,
      'is_public': super.isPublic ? '1' : '0',
      'handle': super.handle,
      'id': super.id.toString(),
      'is_member': super.isMemeber ? '1' : '0',
      'owner_id': super.ownerID.toString(),
    };
  }

// used when create a new community
  factory CommunityModel.fromEntity(Community community) {
    return CommunityModel(
      id: community.id,
      name: community.name,
      description: community.description,
      isPublic: community.isPublic,
      handle: community.handle,
      numOfMemebers: community.numOfMemebers,
      avatar: community.avatar,
      isMemeber: community.isMemeber,
      ownerID: community.ownerID,
    );
  }
}
