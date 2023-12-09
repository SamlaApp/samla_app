import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/friends/chat_di.dart';
import 'package:samla_app/features/friends/presentation/cubit/friendShip/friend_ship_cubit.dart';
import 'package:samla_app/features/friends/presentation/cubit/friends/friends_cubit.dart';
import 'package:samla_app/features/friends/presentation/cubit/messages/messages_cubit.dart';

import '../../../../core/widgets/image_viewer.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/message.dart';
import 'FriendProfilePage.dart';

class ChatPage extends StatelessWidget {
  final int userID;
  final User friend;

  ChatPage({super.key, required this.userID, required this.friend});

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final messagesCubit = sl<MessagesCubit>();
    final statusCubit = sl<FriendShipCubit>()..getStatus(userID);
    final friendCubit = sl<FriendCubit>();
    final _baseImageUrl =
        'https://chat.mohsowa.com/api/image'; // Replace with your image URL
    //frint has these
    print(friend.id);
    print(friend.name);
    print(friend.email);
    print(friend.image);
    print(friend.photoUrl);

    // Function to build AppBar with user's profile and name
    AppBar _buildAppBar(user) {
      return AppBar(
        title: Row(
          children: [
            ClipOval(
              child: Material(
                color: Colors.transparent,
                child: ImageViewer.network(
                  placeholderImagePath: 'images/defaults/user.png',
                  imageURL: _baseImageUrl + (user.photoUrl ?? ''),
                  // Use empty string as default if photoUrl is null
                  width: 45,
                  height: 45,
                ),
              ),
            ),
            SizedBox(width: 10),
            // Space between image and name
            InkWell(
              onTap: () {
                // Navigate to the friend's profile page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FriendProfilePage(),
                  ),
                );
              },
              child: Text(
                user.name ?? '',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        // gradient:
        backgroundColor: themeDarkBlue.withOpacity(.8),
        iconTheme: IconThemeData(color: Colors.white),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(friend),
      body: BlocBuilder<FriendShipCubit, FriendShipState>(
        bloc: statusCubit,
        builder: (context, state) {
          if (state is FriendShipLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FriendShipError) {
            return Center(child: Text(state.message));
          } else if (state is FriendShipLoaded) {
            return _buildChatInterface(
                state, context, friendCubit, messagesCubit);
          }
          return Center(child: Text('Something went wrong'));
        },
      ),
    );
  }

  Widget _buildChatInterface(FriendShipLoaded state, BuildContext context,
      FriendCubit friendCubit, MessagesCubit messagesCubit) {
    return Column(
      children: [
        if (state.status.status == 'pending')
          _buildFriendRequestButtons(context, state.status.id, friendCubit),
        Expanded(child: _buildMessagesSection(messagesCubit, state.status.id)),
        _buildMessageInputField(
            messagesCubit, _messageController, state.status.id),
      ],
    );
  }

  Widget _buildFriendRequestButtons(
      BuildContext context, int friendRequestId, FriendCubit friendCubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () async {
            await friendCubit.acceptFriend(friendRequestId);
            // Additional logic if needed
          },
          child: Text('Accept'),
          style: TextButton.styleFrom(
            backgroundColor: Colors.green, // Replace with your color
            primary: Colors.white, // Text color
          ),
        ),
        SizedBox(width: 10),
        TextButton(
          onPressed: () async {
            await friendCubit.rejectFriend(friendRequestId);
            Navigator.pop(context);
          },
          child: Text('Reject'),
          style: TextButton.styleFrom(
            backgroundColor: Colors.red, // Replace with your color
            primary: Colors.white, // Text color
          ),
        ),
      ],
    );
  }

  // still not done with the ui i just want to see if it works ;)
  Widget _buildMessagesSection(MessagesCubit messagesCubit, int friendID) {
    return BlocBuilder<MessagesCubit, MessagesState>(
      bloc: messagesCubit..getMessages(friend_id: friendID),
      builder: (context, messagesState) {
        if (messagesState is MessagesLoaded) {
          // Build the messages list
          return ListView.builder(
            itemCount: messagesState.messages.length,
            itemBuilder: (context, index) {
              final message = messagesState.messages[index];
              // Add message list item UI
              return ListTile(
                title: Text(message.message.toString()),
              );
            },
          );
        } else if (messagesState is MessagesError) {
          return Center(child: Text(messagesState.message));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildMessageInputField(MessagesCubit messagesCubit,
      TextEditingController messageController, int friendID) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: SafeArea(
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: "Type a message",
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (messageController.text.isNotEmpty) {
                print('Sending message: ${messageController.text}');
                print('Friend ID: $friendID');
                messagesCubit.sendMessage(
                    friend_id: 6,
                    message: _messageController.text,
                    type:
                        'text' // Assuming 'text' is a valid type in your setup
                    );
                messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
