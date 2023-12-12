import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:samla_app/features/friends/data/models/friend_status.dart';
import 'package:samla_app/features/friends/domain/entities/message.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/samlaAPI.dart';
import '../../../auth/data/models/user_model.dart';
import '../models/message_model.dart';
import 'package:http_parser/http_parser.dart';

abstract class RemoteDataSource {
  // searchExplore
  Future<List<UserModel>> searchExplore(String query);

  //addFriend
  Future<FriendStatusModel> addFriend(int friendId);

  //getFriends
  Future<List<UserModel>> getFriends();

  // getFriendshipStatus
  Future<FriendStatusModel> getFriendshipStatus(int friendId);

  // acceptFriend
  Future<FriendStatusModel> acceptFriend(int id);

  // rejectFriend
  Future<FriendStatusModel> rejectFriend(int id);

  // sendMessage
  Future<List<MessageModel>> sendMessage(MessageModel messageModel);

  // getMessages
  Future<List<MessageModel>> getMessages(int friend_id);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl();

  // searchExplore
  @override
  Future<List<UserModel>> searchExplore(String query) async {
    try {
      final res = await samlaAPI(data: {
        'search': query,
      }, endPoint: '/chat/explore_search', method: 'POST');
      final Map<String, dynamic> resBody =
          json.decode(await res.stream.bytesToString());
      if (res.statusCode != 200) {
        throw ServerException(message: resBody['message']);


        
      }

      if (resBody['users'] is List) {
        final users = resBody['users'].map<UserModel>((user) {
          return UserModel.fromJson(user);
        }).toList();
        return users;
      }
      


      final arr = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  
      // check if the first key is one of the above

      bool isDigit = false;
      arr.forEach((element) {
        if (resBody['users'].keys.first == element) {
          isDigit = true;
        }
      });
      if (isDigit) {
        resBody['users'] = [resBody['users'][resBody['users'].keys.first]];
      }

      final users = resBody['users'].map<UserModel>((user) {
        return UserModel.fromJson(user);
      }).toList();
      return users;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  //addFriend
  @override
  Future<FriendStatusModel> addFriend(int friendId) async {
    try {
      final res = await samlaAPI(data: {
        'friend_id': friendId.toString(),
      }, endPoint: '/chat/friend/add', method: 'POST');
      final resBody = json.decode(await res.stream.bytesToString());
      if (res.statusCode != 200) {
        throw ServerException(message: resBody['message']);
      }
      final status = FriendStatusModel.fromJson(resBody['friend']);
      return status;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  //getFriends
  @override
  Future<List<UserModel>> getFriends() async {
    try {
      final res =
          await samlaAPI(endPoint: '/chat/friend/all/get', method: 'GET');
      final resBody = json.decode(await res.stream.bytesToString());
      if (res.statusCode != 200) {
        throw ServerException(message: resBody['message']);
      }
      final friends = resBody['friends'].map<UserModel>((friend) {
        return UserModel.fromJson(friend);
      }).toList();
      return friends;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  //getFriendshipStatus
  @override
  Future<FriendStatusModel> getFriendshipStatus(int friendId) async {
    try {
      final res = await samlaAPI(
        endPoint: '/chat/friend/get/$friendId',
        method: 'GET',
      );
      final resBody = json.decode(await res.stream.bytesToString());
      if (res.statusCode != 200) {
        throw ServerException(message: resBody['message']);
      }
      final status = FriendStatusModel.fromJson(resBody['friend']);
      return status;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  //acceptFriend
  @override
  Future<FriendStatusModel> acceptFriend(int id) async {
    try {
      final res = await samlaAPI(
          endPoint: '/chat/friend/accept',
          method: 'POST',
          data: {
            'id': id.toString(),
          });
      final resBody = json.decode(await res.stream.bytesToString());
      if (res.statusCode != 200) {
        throw ServerException(message: resBody['message']);
      }
      final status = FriendStatusModel.fromJson(resBody['friend']);
      return status;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  //rejectFriend
  @override
  Future<FriendStatusModel> rejectFriend(int id) async {
    try {
      final res = await samlaAPI(
          endPoint: '/chat/friend/reject',
          method: 'POST',
          data: {
            'id': id.toString(),
          });
      final resBody = json.decode(await res.stream.bytesToString());
      if (res.statusCode != 200) {
        throw ServerException(message: resBody['message']);
      }
      final status = FriendStatusModel.fromJson(resBody['friend']);
      return status;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  // ####this has to check the type if it's text or image or both####

  // sendMessage
  @override
  Future<List<MessageModel>> sendMessage(MessageModel message) async {
    try {
      http.MultipartFile? multipartFile = null;
      final file = message.imageFile;

      if (file != null) {
        multipartFile = http.MultipartFile(
          'image', // The field name in the multipart request
          http.ByteStream(file!.openRead()),
          await file!.length(),
          filename: 'image.jpg',
          contentType: MediaType('image', 'jpeg'),
        );
      }
      final res = await samlaAPI(
          endPoint: '/chat/message/send',
          method: 'POST',
          data: {
            'friend_id': message.friend_id.toString(),
            'message': message.message!,
            'type': message.type,
          },
          file: multipartFile);

      final resBody = json.decode(await res.stream.bytesToString());

      if (res.statusCode != 200) {
        throw ServerException(message: resBody['message']);
      }

      if (resBody.containsKey('messages') && resBody['messages'] is List) {
        final messages = resBody['messages'].map<MessageModel>((message) {
          return MessageModel.fromJson(message);
        }).toList();
        return messages;
      } else {
        throw ServerException(message: 'Invalid response format for messages.');
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  //getMessages
  @override
  Future<List<MessageModel>> getMessages(int friend_id) async {
    try {
      final res = await samlaAPI(
        endPoint: '/chat/message/get/$friend_id',
        method: 'GET',
      );
      final resBody = json.decode(await res.stream.bytesToString());
      if (res.statusCode != 200) {
        throw ServerException(message: resBody['message']);
      }
      final messages = resBody['messages'].map<MessageModel>((message) {
        return MessageModel.fromJson(message);
      }).toList();
      return messages;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}

void main(List<String> args) async {
  try {
    final datasource = RemoteDataSourceImpl();
    // final friends = await datasource.getFriends();
    // print(friends[0].name);

    // final friendStatus = await datasource.addFriend(5);
    // final friendStatus = await datasource.rejectFriend(8);
    // final friendStatus = await datasource.acceptFriend(10);
    // final friendStatus = await datasource.getFriendshipStatus(4);
    final explore = await datasource.searchExplore('adhm');
    // print(explore[0].name);

    // final msg = await datasource.sendMessage(
    //     MessageModel(friend_id: 3, message: 'hello, world!', type: 'text'));
    // print(msg[0].message);

    // final msg = await datasource.getMessages(3);
    // print(msg[0].message);
  } on ServerException catch (e) {
    // TODO
    print(e.message);
  }
}
