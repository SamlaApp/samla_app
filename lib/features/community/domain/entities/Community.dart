import 'dart:io';

import 'package:equatable/equatable.dart';

class Community extends Equatable {
  final String name;
  final String description;
  final bool isPublic;
  final String handle;
  bool isMemeber;
  final int ownerID;
  final int? numOfMemebers;
  //these are depend on the direction of transfer
  //whether it coming from backend, or going to backend
  final int? id;
  final File? avatar; //image name in the backend
  final String? imageURL; //full link that include image name in the backend

  Community(
      {required this.name,
      required this.description,
      required this.isPublic,
      required this.handle,
      required this.numOfMemebers,
      required this.ownerID,
      this.avatar,
      this.id,
      this.imageURL,
      required this.isMemeber});

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        description,
        isPublic,
        handle,
        numOfMemebers,
        avatar,
        id,
      ];

  Community copyWith(
      {String? name,
      String? description,
      bool? isPublic,
      String? handle,
      int? numOfMemebers,
      File? avatar,
      int? id,
      String? imageURL,
      bool? isMemeber,
      int? ownerID}) {
    return Community(
        name: name ?? this.name,
        description: description ?? this.description,
        isPublic: isPublic ?? this.isPublic,
        handle: handle ?? this.handle,
        numOfMemebers: numOfMemebers ?? this.numOfMemebers,
        avatar: avatar ?? this.avatar,
        id: id ?? this.id,
        imageURL: imageURL ?? this.imageURL,
        isMemeber: isMemeber ?? this.isMemeber,
        ownerID: ownerID ?? this.ownerID);
  }
}
