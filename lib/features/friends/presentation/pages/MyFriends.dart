import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'package:samla_app/features/friends/presentation/cubit/friends/friends_cubit.dart';
// Add any other necessary imports

class MyFriendsWidget extends StatelessWidget {
  final FriendCubit friendCubit;

  MyFriendsWidget({Key? key, required this.friendCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendCubit, FriendState>(
      bloc: friendCubit,
      builder: (context, state) {
        if (state is FriendLoading) {
          return Center(
              child: CircularProgressIndicator(
            color: themeBlue,
            backgroundColor: themePink,
          ));
        } else if (state is FriendListLoaded) {
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
                    },
                    child: ListTile(
                      leading: ClipOval(
                        child: CircleAvatar(
                          backgroundColor: themeBlue,
                          radius: 28,
                          child: Image.network(
                            'http://example.com/${user.photoUrl}',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              print(user.name);
                              return Icon(Icons.person,
                                  color: themeDarkBlue, size: 40);
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: themeBlue,
                                  backgroundColor: themePink,
                                ),
                              );
                            },
                          ),
                        ),
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
