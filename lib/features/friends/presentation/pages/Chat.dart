import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:samla_app/features/friends/chat_di.dart';
import 'package:samla_app/features/friends/presentation/cubit/friendShip/friend_ship_cubit.dart';
import 'package:samla_app/features/friends/presentation/cubit/friends/friends_cubit.dart';
import 'package:samla_app/features/friends/presentation/cubit/messages/messages_cubit.dart';

class ChatPage extends StatelessWidget {
  final int userID;
  const ChatPage({super.key, required this.userID});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<MessagesCubit>();
    final statusCubit = sl<FriendShipCubit>()..getStatus(userID);
    final friendCubit = sl<FriendCubit>();

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<FriendShipCubit, FriendShipState>(
        bloc: statusCubit,
        builder: (context, state) {
          if (state is FriendShipLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FriendShipError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is FriendShipLoaded) {
            if (state.status.status == 'pending') {
              return Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: () async {
                          await friendCubit.acceptFriend(state.status.id);
                          await statusCubit.getStatus(userID);
                        },
                        child: Text('accept'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await friendCubit.rejectFriend(state.status.id);
                          await statusCubit.getStatus(userID);
                          Navigator.pop(context);
                        },
                        child: Text('Reject'),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  _buildMessages(cubit, state.status.id)
                ],
              );
            } else {
              return _buildMessages(cubit, state.status.id);
            }
          }
          return Center(
            child: Text('Something went wrong'),
          );
        },
      ),
    );
  }

  BlocBuilder<MessagesCubit, MessagesState> _buildMessages(
      MessagesCubit cubit, int friendID) {
    return BlocBuilder<MessagesCubit, MessagesState>(
      bloc: cubit..getMessages(friend_id: friendID),
      builder: (context, messagesState) {
        print(messagesState);

        if (messagesState is MessagesLoaded) {
          return Column(
            children: [
              Text('number of messages:${messagesState.messages.length}'),
              SizedBox(
                height: 30,
              ),
            ],
          );
        }
        if (messagesState is MessagesError) {
          return Center(
            child: Text(messagesState.message),
          );
        }
        return Container();
      },
    );
  }
}
