import 'dart:io';

import 'package:equatable/equatable.dart';

class Community extends Equatable{
  final String name;
  final String description;
  final bool isPublic;
  final String handle;
  final int numOfMemebers;
  //these are depend on the direction of transfer
  //whether it coming from backend, or going to backend
  final String? id;
  final File? avatar; //image name in the backend
  final String? imageURL; //full link that include image name in the backend

  const Community( 
      {required this.name,
      required this.description,
      required this.isPublic,
      required this.handle,
      required this.numOfMemebers,
      this.avatar,
      this.id,
      this.imageURL});
      
        @override
        // TODO: implement props
        List<Object?> get props => [name,description,isPublic,handle,numOfMemebers,avatar,id,imageURL];
}
