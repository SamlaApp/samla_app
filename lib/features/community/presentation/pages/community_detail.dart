import 'dart:io';
import 'dart:math';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/core/widgets/ConfirmationModal.dart';
import 'package:samla_app/core/widgets/image_helper.dart';
import 'package:samla_app/core/widgets/image_viewer.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/presentation/cubits/ExploreCubit/explore_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/MyCommunitiesCubit/community_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/SpecificCommunityCubit/specific_community_cubit.dart';
import 'package:samla_app/features/community/presentation/pages/community_page.dart';

enum userRoleOptions { owner, member, notMember }

class CommunityDetail extends StatelessWidget {
  final Community community;

  const CommunityDetail({super.key, required this.community});

  @override
  Widget build(BuildContext context) {
    final specificCubit = sl.get<SpecificCommunityCubit>();
    final communityCubit = sl.get<CommunityCubit>();
    final exploreCubit = sl.get<ExploreCubit>();
    final user = sl.get<AuthBloc>().user;
    specificCubit.getCommunitynumOfMemebers(community.id!);
    final userRole = community.ownerID == int.parse(user.id!)
        ? userRoleOptions.owner
        : community.isMemeber
            ? userRoleOptions.member
            : userRoleOptions.notMember;
    return BlocProvider(
      create: (context) => specificCubit,
      child: BlocBuilder<SpecificCommunityCubit, SpecificCommunityState>(
        builder: (context, state) {
          if (state is SpecificCommunityError) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            });
          }

          return Scaffold(
            // appBar: GradientAppBar(context),
            body: Stack(
              children: [
                Positioned(
                  child: GradientAppBar(context),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: SafeArea(
                    child: Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // main contents
                          SizedBox(
                            height: 80,
                          ),

                          ImageViewer.network(
                            placeholderImagePath: 'images/defaults/community.png',
                            imageURL: community.imageURL,
                            editableCallback: (image) {},
                            title: community.name,
                            animationTag: 'imageHero',
                          ),

                          SizedBox(height: 10),

                          Text(community.name!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  decoration: TextDecoration.none,
                                  color: theme_darkblue.withOpacity(0.95))),

                          SizedBox(height: 5),

                          // community handle
                          Text(community.handle!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  decoration: TextDecoration.none,
                                  color: theme_darkblue.withOpacity(0.5))),

                          SizedBox(height: 30),

                          // row of number of memebers and public/private
                          MermbersCountWidget(
                            numOfMembers: state is SpecificCommunityNumberLoaded
                                ? state.numOfMembers.toString()
                                : '0',
                            publicOrPrivate:
                                community.isPublic ? 'PUBLIC' : 'PRIVATE',
                          ),
                          SizedBox(height: 10),

                          OverViewWidget(overview: community.description),
                          SizedBox(
                            height: 30,
                          ),

                          mainButton(
                              userRole, context, exploreCubit, communityCubit),
                        ]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Align mainButton(userRoleOptions userRole, BuildContext context,
      ExploreCubit exploreCubit, CommunityCubit communityCubit) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: community.isMemeber
                ? [theme_red, theme_pink]
                : [
                    theme_green,
                    // Replace with your theme_green color
                    theme_pink // Replace with your theme_pink color
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        height: 60,
        child: TextButton(
          onPressed: () {
            // show a bottom sheet modal

            callback([String? err]) {
              if (err == null) {
                if (userRole == userRoleOptions.owner ||
                    userRole == userRoleOptions.member) {
                  Navigator.of(context).popUntil((route) {
                    return route.settings.name == '/MainPages';
                  });
                  exploreCubit.getAllCommunities();
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommunityPage(
                          community: community.copyWith(isMemeber: true)),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(err),
                  ),
                );
              }
            }

            if (userRole == userRoleOptions.owner) {
              showConfirmationModal(
                  context: context,
                  message: 'Are you sure you want to delete this community?',
                  confirmCallback: () {
                    communityCubit.deleteCommunity(community.id!, callback);
                  },
                  buttonLabel: 'Delete');
            } else if (userRole == userRoleOptions.member) {
              showConfirmationModal(
                  context: context,
                  message: 'Are you sure you want to leave this community?',
                  confirmCallback: () {
                    communityCubit.leaveCommunity(community.id!, callback);
                  },
                  buttonLabel: 'Leave');
            } else if (userRole == userRoleOptions.notMember) {
              exploreCubit.joinCommunity(community.id!, callback);
            }
          },
          child: Text(
              userRole == userRoleOptions.owner
                  ? 'Delete Community'
                  : userRole == userRoleOptions.member
                      ? 'Leave Community'
                      : 'Join Community',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  decoration: TextDecoration.none,
                  color: primary_color.withOpacity(0.95))),
        ),
      ),
    );
  }
}

class OverViewWidget extends StatelessWidget {
  final String overview;
  const OverViewWidget({
    super.key,
    required this.overview,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: primary_decoration,
      width: double.maxFinite,
      child: Column(children: [
        Text('Overview',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                decoration: TextDecoration.none,
                color: theme_darkblue.withOpacity(0.75))),
        SizedBox(height: 10),
        SizedBox(
          width: double.maxFinite,
          child: Text(overview,
              style: TextStyle(
                  fontSize: 14, color: theme_darkblue.withOpacity(0.8))),
        )
      ]),
    );
  }
}

class MermbersCountWidget extends StatelessWidget {
  final String numOfMembers;
  final String publicOrPrivate;

  const MermbersCountWidget({
    super.key,
    required this.numOfMembers,
    required this.publicOrPrivate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
      decoration: primary_decoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(numOfMembers,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      color: theme_green)),
              SizedBox(height: 5),
              Text('Members',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      decoration: TextDecoration.none,
                      color: theme_darkblue.withOpacity(0.5))),
            ],
          ),
          Column(
            children: [
              Text(publicOrPrivate,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      color: theme_green)),
              SizedBox(height: 5),
              Text('Community',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      decoration: TextDecoration.none,
                      color: theme_darkblue.withOpacity(0.5))),
            ],
          ),
        ],
      ),
    );
  }
}

PreferredSize GradientAppBar(context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(190),
    child: Container(
      height: 190,
      child: AppBar(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        toolbarHeight: 150,
        flexibleSpace: AnimateGradient(
          primaryBegin: Alignment.topLeft,
          primaryEnd: Alignment.bottomLeft,
          secondaryBegin: Alignment.bottomRight,
          secondaryEnd: Alignment.topLeft,
          primaryColors: [
            theme_green,
            Colors.blueAccent,
          ],
          secondaryColors: [theme_green, Color.fromARGB(255, 120, 90, 255)],
        ),
      ),
    ),
  );
}
