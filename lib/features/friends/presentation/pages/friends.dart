import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'package:samla_app/core/widgets/CustomTextFormField.dart';
import 'package:samla_app/features/friends/presentation/cubit/explore/explore_cubit.dart';

// import as chat_di
import 'package:samla_app/features/friends/chat_di.dart' as chat_di;
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../cubit/friends/friends_cubit.dart';
import 'package:samla_app/features/main/home_di.dart' as di;
import 'package:get_it/get_it.dart';

class FriendsPage extends StatefulWidget {
  FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final _searchController = TextEditingController();
  int selectedIndex = 0;
  final user = di.sl.get<AuthBloc>().user;

  // Accessing FriendCubit instance
  late FriendCubit friendCubit;

  late ExploreCubit exploreCubit;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // Initialize friendCubit
    chat_di.chatInit();
    friendCubit = chat_di.sl.get<FriendCubit>();
    exploreCubit = chat_di.sl.get<ExploreCubit>();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends Page'),
      ),
      body: Container(
        color: inputFieldColor,
        height: double.maxFinite,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Search bar
                Container(
                  decoration: primaryDecoration,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: _searchController,
                              label: 'Search for friends',
                              iconData: Icons.search,
                              onChanged: (value) {
                                if (value.length > 2)
                                  exploreCubit.searchExplore(value);
                              },
                            ),
                          ),
                        ],
                      ),
                      ButtonsBar(selectedIndex, (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      }),
                    ],
                  ),
                ),

                const SizedBox(height: 20.0),
                Container(
                  decoration: primaryDecoration,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Content for My Friends or Explore
                      // selectedIndex == 0
                      //     ? myFriendsBuilder(friendCubit)
                      //     : exploreBuilder(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget myFriendsBuilder(FriendCubit friendCubit) {
  //   return BlocBuilder<FriendCubit, FriendState>(
  //     builder: (context, state) {
  //       if (state is FriendListLoaded) {
  //         return ListView.builder(
  //           shrinkWrap: true,
  //           itemCount: state.friends.length,
  //           itemBuilder: (context, index) {
  //             final friend = state.friends[index];
  //             return ListTile(
  //               title: Text(friend.name),
  //               // Add more friend details here
  //             );
  //           },
  //         );
  //       } else if (state is FriendLoading) {
  //         return CircularProgressIndicator();
  //       } else {
  //         return Text('No friends found');
  //       }
  //     },
  //   );
  // }

  Widget exploreBuilder() {
    // Logic to build the Explore section
    return Center(
      child: Text(
        'Explore Content',
        style: TextStyle(
            color: themeDarkBlue.withOpacity(0.7),
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}

Widget ButtonsBar(int currentIndex, Function(int) onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Container(
          decoration: currentIndex == 0
              ? const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: themeBlue, width: 3.0),
                  ),
                )
              : null,
          child: TextButton(
            onPressed: () => onTap(0),
            child: Text(
              'My Friends',
              style: TextStyle(
                color: currentIndex == 0 ? themeBlue : themeGrey,
                fontSize: 16,
                fontWeight:
                    currentIndex == 0 ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Container(
          decoration: currentIndex == 1
              ? const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: themeBlue, width: 3.0),
                  ),
                )
              : null,
          child: TextButton(
            onPressed: () => onTap(1),
            child: Text(
              'Explore',
              style: TextStyle(
                color: currentIndex == 1 ? themeBlue : themeGrey,
                fontSize: 16,
                fontWeight:
                    currentIndex == 1 ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
