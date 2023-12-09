import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'package:samla_app/features/friends/presentation/cubit/explore/explore_cubit.dart';

class ExploreWidget extends StatelessWidget {
  final ExploreCubit exploreCubit;

  ExploreWidget({Key? key, required this.exploreCubit}) : super(key: key);

  final String _baseImageUrl = 'https://chat.mohsowa.com/api/image';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      bloc: exploreCubit,
      builder: (context, state) {
        if (state is ExploreLoading) {
          return Center(
              child: CircularProgressIndicator(
            color: themeBlue,
            backgroundColor: themePink,
          ));
        } else if (state is ExploreLoaded) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                  child: InkWell(
                    onTap: () {
                      // Handle the tap event
                      print('$_baseImageUrl${user.photoUrl}');
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: themeBlue,
                        radius: 28,
                        child: Image.network(
                          '$_baseImageUrl${user.photoUrl}',
                          fit: BoxFit.cover,
                          // Add errorBuilder and loadingBuilder
                          // ...
                        ),
                      ),
                      title: Text(user.name,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          )),
                      subtitle: Text('@${user.username}',
                          style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .color!
                                .withOpacity(0.7),
                          )),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.person_add,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                        onPressed: () {
                          // Logic for adding friend
                          // ...
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is ExploreError) {
          return Center(child: Text(state.message));
        } else if (state is ExploreEmpty) {
          return _noUsersFound(context);
        } else {
          return _noUsersFound(context);
        }
      },
    );
  }

  Widget _noUsersFound(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 60,
            color:
                Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7),
          ),
          Text(
            'No users found',
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
