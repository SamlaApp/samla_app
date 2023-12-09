import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:samla_app/features/friends/data/models/friend_status.dart';
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
  Future<List<MessageModel>> sendMessage(MessageModel message);

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
      final resBody = json.decode(await res.stream.bytesToString());
      if (res.statusCode != 200) {
        throw ServerException(message: resBody['message']);
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
      print(resBody);
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
      print(resBody);
      final status = FriendStatusModel.fromJson(resBody['friend']);
      return status;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  //sendMessage
  @override
  Future<List<MessageModel>> sendMessage(MessageModel message) async {
    try {
      http.MultipartFile? multipartFile = null;

      if (message.imageFile != null) {
        multipartFile = http.MultipartFile(
          'image', // The field name in the multipart request
          http.ByteStream(message.imageFile!.openRead()),
          await message.imageFile!.length(),
          filename: 'image.jpg',
          contentType: MediaType('image', 'jpeg'),
        );
      }
      final res = await samlaAPI(
          endPoint: '/chat/message/send',
          method: 'POST',
          data: message.toJson(),
          file: multipartFile);

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
    final friends = await datasource.getFriends();
    print(friends[0].name);

    // final friendStatus = await datasource.addFriend(5);
    // final friendStatus = await datasource.rejectFriend(8);
    // final friendStatus = await datasource.acceptFriend(10);
    // final friendStatus = await datasource.getFriendshipStatus(4);
    // final explore = await datasource.searchExplore('adhm');
    // // print(explore[0].name);

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
