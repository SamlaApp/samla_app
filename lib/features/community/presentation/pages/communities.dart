import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/core/widgets/CustomTextFormField.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/community/presentation/cubits/ExploreCubit/explore_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/MyCommunitiesCubit/community_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/Search/search_cubit.dart';
import 'package:samla_app/features/community/presentation/pages/create_community.dart';
import 'package:samla_app/features/community/presentation/widgets/community_list.dart';
import 'package:samla_app/features/community/community_di.dart' as di;

class CommunitiesPage extends StatefulWidget {
  CommunitiesPage({super.key});

  @override
  State<CommunitiesPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunitiesPage> {
  // init the cubits
  late CommunityCubit communityCubit;
  late ExploreCubit exploreCubit;
  late SearchCubit searchCubit;

  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // This code runs when the widget is first created
    // You can perform any setup or initial actions here
    di.CommunityInit();
    communityCubit = di.sl.get<CommunityCubit>();
    exploreCubit = di.sl.get<ExploreCubit>();
    searchCubit = di.sl.get<SearchCubit>();
  }

  final user = di.sl.get<AuthBloc>().user;

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    communityCubit.getMyCommunities();
    return Container(
      color: inputField_color,
      height: double.maxFinite,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // search bar here
              Container(
                decoration: primary_decoration,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  // search field
                  children: [
                    // adding floating button

                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            onChanged: (value) {
                                searchCubit.search(value);
                              
                            },
                            controller: _searchController,
                            label: 'Search for a community',
                            iconData: Icons.search,
                          ),
                        ),
                        IconButton.filled(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateCommunityPage()),
                            );
                          },
                          icon: const Icon(Icons.add),
                          color: theme_green,
                        )
                      ],
                    ),
                    ButtonsBar(selectedIndex, (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    }, (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    })
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),

              Container(
                  constraints: const BoxConstraints(minHeight: 300),
                  decoration: primary_decoration,
                  padding: const EdgeInsets.all(5.0),
                  child: BlocBuilder<SearchCubit, SearchState>(
                    bloc: searchCubit,
                    builder: (context, state) {
                      if (_searchController.value != null &&
                          _searchController.value.text.isNotEmpty) {
                        return searchCommunitiesBuilder();
                      } else if (selectedIndex == 0) {
                        return myCommunitiesBuilder();
                      } else {
                        return exploreCommunitiesBuilder();
                      }
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  BlocBuilder<CommunityCubit, CommunityState> searchCommunitiesBuilder() {
    // communityCubit.getMyCommunities();
    return BlocBuilder<CommunityCubit, CommunityState>(
      bloc: communityCubit,
      builder: (context, myCommunityState) {
        if (myCommunityState is CommunityLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: theme_green,
              backgroundColor: theme_pink,
            ),
          );
        }
        if (myCommunityState is CommunitiesLoaded) {
          return BlocBuilder<SearchCubit, SearchState>(
            bloc: searchCubit,
            builder: (context, state) {
              if (state is SearchLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: theme_green,
                    backgroundColor: theme_pink,
                  ),
                );
              } else if (state is SearchLoaded && state.communities.isNotEmpty) {
                
                state.communities.forEach((searchedCommunity) {
                  myCommunityState.communities.forEach((myCommunity) {
                    if (searchedCommunity.id == myCommunity.id) {
                      searchedCommunity.isMemeber = true;
                    }
                  });
                });
                return Column(
                    children: buildCommunitiesList(state.communities, false));
              } else if (state is SearchError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text('No such a community'));
            },
          );
        } else if (myCommunityState is CommunityError) {
          return Center(child: Text(myCommunityState.message));
        } else
          return const Center(child: Text('Failed try agian later'));
      },
    );
  }

  BlocBuilder<CommunityCubit, CommunityState> myCommunitiesBuilder() {
    communityCubit.getMyCommunities();
    return BlocBuilder<CommunityCubit, CommunityState>(
      bloc: communityCubit,
      builder: (context, state) {
        if (state is CommunityLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: theme_green,
              backgroundColor: theme_pink,
            ),
          );
        }
        if (state is CommunitiesLoaded) {
          return Column(
              children: buildCommunitiesList(state.communities, false));
        } else if (state is CommunityError) {
          return Center(child: Text(state.message));
        } else
          return const Center(child: Text('You are not in any community'));
      },
    );
  }

  BlocBuilder<ExploreCubit, ExploreState> exploreCommunitiesBuilder() {
    exploreCubit.getAllCommunities();

    return BlocBuilder<ExploreCubit, ExploreState>(
      bloc: exploreCubit,
      builder: (context, state) {
        if (state is ExploreEmpty) {
          return const Center(
            child: Text('No communities found'),
          );
        }

        if (state is ExploreLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: theme_green,
              backgroundColor: theme_pink,
            ),
          );
        }
        if (state is ExploreLoaded) {
          return Column(
              children: buildCommunitiesList(state.communities, true));
        } else if (state is ExploreError) {
          return Center(child: Text(state.message));
        } else
          return const Text('No data');
      },
    );
  }
}

Widget ButtonsBar(int currentIndex, Function(int) myCommunitiesOnTap,
    Function(int) allCommunitiesOnTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Container(
          // if this selected bottom border should be colored
          decoration: currentIndex == 0
              ? BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                  color: theme_green,
                  width: 3.0,
                )))
              : null,
          child: TextButton(
            onPressed: () {
              myCommunitiesOnTap(0);
            },
            child: Text(
              'Communities',
              style: TextStyle(
                  color: currentIndex == 0 ? theme_green : theme_grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      Expanded(
        child: Container(
          // if this selected bottom border should be colored
          decoration: currentIndex == 1
              ? BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                  color: theme_green,
                  width: 3.0,
                )))
              : null,
          child: TextButton(
            onPressed: () {
              allCommunitiesOnTap(1);
            },
            child: Text(
              'Explore',
              style: TextStyle(
                  color: currentIndex == 1 ? theme_green : theme_grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ],
  );
}
