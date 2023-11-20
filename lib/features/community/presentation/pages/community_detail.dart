import 'dart:io';
import 'dart:math';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/core/widgets/ConfirmationModal.dart';
import 'package:samla_app/core/widgets/CustomTextFormField.dart';
import 'package:samla_app/core/widgets/image_viewer.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/presentation/cubits/ExploreCubit/explore_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/ManageMemebers/get_memebers_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/MyCommunitiesCubit/community_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/RequestsManager/requests_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/SpecificCommunityCubit/specific_community_cubit.dart';
import 'package:samla_app/features/community/presentation/pages/community_page.dart';
import 'package:samla_app/features/community/presentation/pages/join_requests.dart';
import 'package:samla_app/core/widgets/route_transition.dart';

enum userRoleOptions { owner, member, notMember }

class CommunityDetail extends StatelessWidget {
  Community community;

  CommunityDetail(
      {super.key, required this.community, this.updateNameAndImageCallback});
  final Function(String name, String? imageURL)? updateNameAndImageCallback;
  final specificCubit = sl.get<SpecificCommunityCubit>();
  final communityCubit = sl.get<CommunityCubit>();
  final exploreCubit = sl.get<ExploreCubit>();
  final user = sl.get<AuthBloc>().user;
  final memebersCubit = sl.get<MemebersCubit>();
  final requestsCubit = sl.get<RequestsCubit>();

  void updateCommunity(newCommunityInfo, {bool updateHandle = true}) {
    specificCubit.updateCommunity(newCommunityInfo, (newCommunity) {
      community = newCommunity.copyWith(
          imageURL: community.imageURL); // do not change the image

      if (updateNameAndImageCallback != null) {
        updateNameAndImageCallback!(newCommunity.name, newCommunity.imageURL);
      }
      communityCubit.getMyCommunities();
    }, updateHandle: updateHandle);
  }

  showUpdateCommunityModal(context, var validator, String title, String label,
      String initialValue, Function(String) callback) {
    showDialog(
        context: context,
        builder: (context) {
          final controller = TextEditingController(text: initialValue);
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(color: theme_grey),
                  ))
            ],
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        decoration: TextDecoration.none,
                        color: theme_darkblue.withOpacity(0.95)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    controller: controller,
                    validator: validator,
                    label: label,
                    iconData: Icons.edit,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 250,
                    height: 40,
                    decoration: primary_decoration.copyWith(color: theme_green),
                    child: TextButton.icon(
                      // stretch the button

                      icon: Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          callback(controller.text);
                          Navigator.pop(context);
                        }
                      },
                      label: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
          if (!community.isPublic && userRole == userRoleOptions.owner) {
            requestsCubit.getJoinRequests(community.id!);
          }
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
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Positioned(
                    child: GradientAppBar(
                        context, userRole, community, requestsCubit),
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
                              placeholderImagePath:
                                  'images/defaults/community.png',
                              imageURL: community.imageURL,
                              editableCallback: userRole ==
                                          userRoleOptions.member ||
                                      userRole == userRoleOptions.owner
                                  ? (image) {
                                      updateCommunity(
                                          community.copyWith(avatar: image));
                                    }
                                  : null,
                              title: community.name,
                              animationTag: 'imageHero',
                            ),

                            SizedBox(height: 10),

                            GestureDetector(
                              onTap: () {
                                if (userRole == userRoleOptions.owner) {
                                  showUpdateCommunityModal(
                                      context,
                                      (value) {
                                        if (value.length < 3) {
                                          return 'Name must be at least 3 characters';
                                        }
                                        return null;
                                      },
                                      'Update Community Name',
                                      'Name',
                                      community.name!,
                                      (value) {
                                        updateCommunity(
                                            community.copyWith(name: value));
                                      });
                                }
                              },
                              child: Text(community.name!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                      decoration: TextDecoration.none,
                                      color: theme_darkblue.withOpacity(0.95))),
                            ),

                            SizedBox(height: 5),

                            // community handle
                            GestureDetector(
                              onTap: () {
                                if (userRole == userRoleOptions.owner) {
                                  showUpdateCommunityModal(
                                      context,
                                      (value) {
                                        if (value.length < 3) {
                                          return 'Handle must be at least 3 characters';
                                        }
                                        return null;
                                      },
                                      'Update Community Handle',
                                      'Handle',
                                      community.handle,
                                      (value) {
                                        if (value != community.handle) {
                                          updateCommunity(
                                              community.copyWith(handle: value),
                                              updateHandle: true);
                                        } else {
                                          SchedulerBinding.instance
                                              .addPostFrameCallback((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Handle is already the same'),
                                              ),
                                            );
                                          });
                                        }
                                      });
                                }
                              },
                              child: Text(community.handle!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      decoration: TextDecoration.none,
                                      color: theme_darkblue.withOpacity(0.5))),
                            ),

                            SizedBox(height: 30),

                            // row of number of memebers and public/private
                            MermbersCountWidget(
                              numOfMembers:
                                  state is SpecificCommunityNumberLoaded
                                      ? state.numOfMembers.toString()
                                      : '0',
                              publicOrPrivate:
                                  community.isPublic ? 'PUBLIC' : 'PRIVATE',
                              requestsCubit: requestsCubit,
                              communityID: community.id!,
                            ),
                            SizedBox(height: 10),

                            GestureDetector(
                                onTap: () {
                                  if (userRole == userRoleOptions.owner) {
                                    showUpdateCommunityModal(
                                        context,
                                        (value) {
                                          if (value.length < 3) {
                                            return 'Description must be at least 3 characters';
                                          }
                                          return null;
                                        },
                                        'Update Community Description',
                                        'Description',
                                        community.description!,
                                        (value) {
                                          updateCommunity(community.copyWith(
                                              description: value));
                                        });
                                  }
                                },
                                child: OverViewWidget(
                                    overview: community.description)),
                            SizedBox(
                              height: 10,
                            ),

                            userRole == userRoleOptions.owner
                                ? _builderMembersWidget(memebersCubit, user)
                                : Container(),
                            SizedBox(
                              height: 30,
                            ),

                            mainButton(userRole, context, exploreCubit,
                                communityCubit),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _builderMembersWidget(MemebersCubit memebersCubit, User user) {
    return BlocBuilder<RequestsCubit, RequestsState>(
      bloc: requestsCubit,
      builder: (context, state) {
        return BlocBuilder<MemebersCubit, MemebersState>(
          buildWhen: (previous, current) {
            if (current is MemebersLoaded) {
              return true;
            }
            return false;
          },
          bloc: memebersCubit..getMemebers(community.id!, community.isPublic),
          builder: (context, state) {
            if (state is MemebersError) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              });
            } else if (state is MemebersLoaded) {
              return Container(
                  decoration: primary_decoration,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        return memberWidget(
                            context, state, index, user, memebersCubit);
                      }));
            }
            // else if (state is MemebersLoading) {
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            return Container();
          },
        );
      },
    );
  }

  Widget memberWidget(context, MemebersLoaded state, int index, User user,
      MemebersCubit memebersCubit) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Container(
                  // put border radius
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  height: 230,
                  width: 200,
                  child: Column(
                    children: [
                      ImageViewer.network(
                        imageURL: state.users[index].photoUrl,
                        placeholderImagePath: 'images/defaults/user.png',
                        animationTag: 'memeberImage$user.id',
                        // viewerMode: false,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        state.users[index].name,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            decoration: TextDecoration.none,
                            color: theme_darkblue.withOpacity(0.95)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '@' + state.users[index].username,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            decoration: TextDecoration.none,
                            color: theme_darkblue.withOpacity(0.5)),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      // delete user button
                      () {
                        if (community.ownerID == int.parse(user.id!) &&
                            state.users[index].id != user.id!) {
                          return Container(
                            width: 250,
                            height: 40,
                            decoration:
                                primary_decoration.copyWith(color: theme_red),
                            child: TextButton.icon(
                              // stretch the button

                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                showConfirmationModal(
                                    context: context,
                                    message:
                                        'Are you sure you want to delete this user?',
                                    confirmCallback: () {
                                      memebersCubit.deleteUser(community.id!,
                                          int.parse(state.users[index].id!),
                                          (err) {
                                        if (err == null) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          specificCubit
                                              .getCommunitynumOfMemebers(
                                                  community.id!);
                                        } else {
                                          Navigator.pop(context);

                                          SchedulerBinding.instance
                                              .addPostFrameCallback((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(err),
                                              ),
                                            );
                                          });
                                        }
                                      }, community.isPublic);
                                    },
                                    buttonLabel: 'Delete');
                              },
                              label: Text(
                                'Delete',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }(),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Close',
                        style: TextStyle(color: theme_grey),
                      ))
                ],
              );
            });
      },
      child: ListTile(
        leading: ImageViewer.network(
          imageURL: state.users[index].photoUrl,
          placeholderImagePath: 'images/defaults/user.png',
          animationTag: 'memeberImage$user.id',
          viewerMode: false,
        ),
        title: Text(
          state is MemebersLoaded ? state.users[index].name : '',
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              decoration: TextDecoration.none,
              color: theme_darkblue.withOpacity(0.95)),
        ),
        subtitle: Text(
          state is MemebersLoaded ? state.users[index].email : '',
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              decoration: TextDecoration.none,
              color: theme_darkblue.withOpacity(0.5)),
        ),
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
            } else if (userRole == userRoleOptions.notMember &&
                community.isPublic) {
              exploreCubit.joinCommunity(community.id!, callback);
            } else {
              exploreCubit.joinCommunity(community.id!, ([String? err]) {
                if (err != null) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(err),
                      ),
                    );
                  });
                } else {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Request sent successfully'),
                      ),
                    );
                  });
                  Navigator.of(context).popUntil((route) {
                    return route.settings.name == '/MainPages';
                  });
                }
              });
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
  final RequestsCubit requestsCubit;
  final int communityID;

  const MermbersCountWidget({
    super.key,
    required this.numOfMembers,
    required this.publicOrPrivate,
    required this.requestsCubit,
    required this.communityID,
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
              BlocBuilder<RequestsCubit, RequestsState>(
                bloc: requestsCubit,
                builder: (context, state) {
                  return BlocBuilder<SpecificCommunityCubit,
                      SpecificCommunityState>(
                    bloc: sl.get<SpecificCommunityCubit>()
                      ..getCommunitynumOfMemebers(communityID),
                    builder: (context, state) {
                      return Text(
                          state is SpecificCommunityNumberLoaded
                              ? state.numOfMembers.toString()
                              : numOfMembers,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              decoration: TextDecoration.none,
                              color: theme_green));
                    },
                  );
                },
              ),
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

PreferredSize GradientAppBar(context, userRoleOptions userRole,
    Community community, RequestsCubit requestsCubit) {
  return PreferredSize(
    preferredSize: Size.fromHeight(190),
    child: Container(
      height: 190,
      child: AppBar(
        actions: [
          // joining requests list only showed for community owner

          () {
            if (userRole == userRoleOptions.owner && !community.isPublic) {
              return Container(
                height: 20,
                width: 50,
                child: Stack(children: [
                  Positioned(
                    top: 15,
                    right: 15,
                    child: IconButton(
                      icon: const Icon(
                        Icons.people,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(slideRouteTransition(JoinRequestsPage(
                          community: community,
                          joinRequestsCubit: requestsCubit,
                        )));
                      },
                    ),
                  ),
                  Positioned(
                      top: 15,
                      right: 5,
                      child: BlocBuilder<RequestsCubit, RequestsState>(
                        bloc: requestsCubit,
                        builder: (context, state) {
                          if (state is RequestsCubitsLoaded &&
                              state.requests.isNotEmpty) {
                            return Container(
                              height: 15,
                              width: 25,
                              // make it circle,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  state.requests.length.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      )),
                ]),
              );
            } else {
              return Container();
            }
          }()
        ],
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
