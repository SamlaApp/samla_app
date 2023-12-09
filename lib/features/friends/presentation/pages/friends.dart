import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/features/friends/presentation/cubit/explore/explore_cubit.dart';
import 'package:samla_app/features/friends/presentation/cubit/friends/friends_cubit.dart';

import '../../../../config/themes/new_style.dart';
import '../../../../core/widgets/CustomTextFormField.dart';
import 'Explore.dart';
import 'MyFriends.dart';

// Add any other necessary imports
import 'package:samla_app/features/friends/chat_di.dart' as chat_di;

class FriendsPage extends StatefulWidget {
  FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final _searchController = TextEditingController();
  int selectedIndex = 0;

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
                              onChanged: (value) async {
                                if (selectedIndex == 0) {
                                  friendCubit.searchFriends(value);
                                } else {
                                  if (value.length > 2) {
                                    await exploreCubit.searchExplore(value);
                                  }
                                }
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
                  child: selectedIndex == 0
                      ? MyFriendsWidget(friendCubit: friendCubit)
                      : ExploreWidget(exploreCubit: exploreCubit),
                )
                // My Friends or Explore Widgets
              ],
            ),
          ),
        ),
      ),
    );
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
                'Chat',
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
}
