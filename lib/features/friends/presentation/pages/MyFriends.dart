import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'package:samla_app/core/widgets/image_viewer.dart';
import 'package:samla_app/features/friends/presentation/cubit/friends/friends_cubit.dart';
import 'package:samla_app/features/friends/presentation/pages/Chat.dart';
// Add any other necessary imports

class MyFriendsWidget extends StatelessWidget {
  final FriendCubit friendCubit;

  MyFriendsWidget({Key? key, required this.friendCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendCubit, FriendState>(
      bloc: friendCubit..getFriends(),
      builder: (context, state) {
        if (state is FriendLoading) {
          return Center(
              child: CircularProgressIndicator(
            color: themeBlue,
            backgroundColor: themePink,
          ));
        } else if (state is FriendLoaded) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
              itemCount: state.friends.length,
              itemBuilder: (context, index) {
                final user = state.friends[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                  child: InkWell(
                    onTap: () {
                      // Implement your onTap action here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatPage(
                                  userID: int.parse(user.id!),
                                  friend: user,
                                )),
                      );
                    },
                    child: ListTile(
                      leading: ClipOval(
                        child: CircleAvatar(
                            backgroundColor: themeBlue,
                            radius: 28,
                            child: ImageViewer.network(
                              imageURL: user.photoUrl,
                              placeholderImagePath: 'images/defaults/user.png',
                              viewerMode: false,
                            )),
                      ),
                      title: Text(
                        user.name,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '@${user.username}',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is FriendError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text('No friends found'));
        }
      },
    );
  }
}
