import 'dart:io';
import 'dart:math';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/core/network/samlaAPI.dart';
import 'package:samla_app/core/widgets/CustomTextFormField.dart';
import 'package:samla_app/core/widgets/image_viewer.dart';
import 'package:samla_app/core/widgets/loading.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/auth/presentation/pages/Register.dart';
import 'package:samla_app/features/community/community_di.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/domain/entities/Post.dart';
import 'package:samla_app/features/community/presentation/cubits/CRUDPostCubit/crud_post_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/GetPosts/get_posts_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/PostCubit/post_cubit.dart';
import 'package:samla_app/features/community/presentation/pages/community_detail.dart';

class CommunityPage extends StatelessWidget {
  final Community community;
  CommunityPage({super.key, required this.community});
  late CrudPostCubit CRUDCubit;
  final userID = sl.get<AuthBloc>().user.id!;
  @override
  Widget build(BuildContext context) {
    CRUDCubit = sl.get<CrudPostCubit>(param1: community.id!);
    return BlocBuilder<CrudPostCubit, CrudPostState>(
      bloc: CRUDCubit,
      builder: (context, state) {
        if (state is CrudPostError) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          });
        }

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showAddPostModal(context);
            },
            child: Icon(Icons.add),
            backgroundColor: theme_pink,
          ),
          appBar: AppBar(
            toolbarHeight: 60,
            backgroundColor: theme_pink,
            titleSpacing: 0,
            // leadingWidth: 35,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: titleWidget(context),
          ),
          body: BlocBuilder<GetPostsCubit, GetPostsState>(
            bloc: sl.get<GetPostsCubit>()..getPosts(community.id!),
            builder: (context, state) {
              if (state is GetPostsLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is GetPostsLoaded) {
                return Container(
                  color: primary_color,
                  child: ListView(
                    children: [
                      () {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            return PostWidget(state.posts[index]);
                          },
                        );
                      }()
                    ],
                  ),
                );
              }
              return Center(child: Text('Something went wrong'));
            },
          ),
        );
      },
    );
  }

  void showAddPostModal(BuildContext context) {
    File? image;
    final textController = TextEditingController();
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: theme_pink,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (context) {
          return Container(
            height: 508,
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: theme_pink,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20.0),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20.0),
                          ),
                          color: primary_color),
                      child: Column(
                        children: [
                          ImageViewer.empty(
                            width: 450,
                            height: 300,
                            isRectangular: true,
                            editableCallback: (_image) {
                              image = _image;
                            },
                          ),
                          SizedBox(height: 20),
                          CustomTextFormField(
                            controller: textController,
                            iconData: Icons.text_fields_rounded,
                            label: 'Post description',
                            textArealike: true,
                          ),
                          SizedBox(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 40,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              decoration: TextDecoration.none,
                                              color: theme_darkblue
                                                  .withOpacity(0.95))),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 40,
                                    child: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                theme_pink),
                                      ),
                                      onPressed: () {
                                        final post = Post(
                                            type: 'image',
                                            writerID: int.parse(userID),
                                            content: textController.text,
                                            communityID: community.id!,
                                            imageFile: image,
                                            numOfLikes: 0);

                                        CRUDCubit.createPost(post);

                                        Navigator.pop(context);
                                      },
                                      child: Text('Post',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              decoration: TextDecoration.none,
                                              color: primary_color
                                                  .withOpacity(0.95))),
                                    ),
                                  ),
                                ),
                              ])
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget PostWidget(Post post) {
    final controller = ExpandableController(initialExpanded: false);

    final cubit = sl.get<PostCubit>();
    return BlocBuilder<PostCubit, PostState>(
      bloc: cubit,
      builder: (context, state) {
        return ExpandablePanel(
          theme: const ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            tapBodyToExpand: true,
            tapBodyToCollapse: true,
            hasIcon: false,
          ),
          collapsed: Container(),
          controller: controller,
          header: GestureDetector(
            onTap: () {
              print('show comments');
              // cubit.showComments();
              controller.toggle();
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(20.0, 10, 20, 0),
              decoration: primary_decoration,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  post.imageURL != null
                      ? ImageViewer.network(
                          animationTag: 'postImage${post.postID}',
                          imageURL: post.imageURL,
                          viewerMode: true,
                          // placeholderImagePath: 'images/defaults/empty.png',
                          width: double.maxFinite,
                          height: 300,
                          isRectangular: true,
                        )
                      : Container(),
                  SizedBox(height: 10),
                  Text('by ${post.writerName}',
                      style: TextStyle(
                          color: theme_darkblue.withOpacity(0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: 5),
                  Text(
                    post.content ?? 'this a dummy content for this post',
                    style: TextStyle(
                        fontSize: 14, color: theme_darkblue.withOpacity(0.6)),
                  )
                ],
              ),
            ),
          ),
          expanded: Container(
            margin: const EdgeInsets.fromLTRB(30.0, 0, 30, 0),
            child: Container(
              child: Center(child: Text('comments not implemented yet')),
              height: 300,
              // rounded corners from bottom only 
              decoration: BoxDecoration(
                color: inputField_color,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  GestureDetector titleWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                CommunityDetail(community: community),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, -1.0); // Slide from the top
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      },
      child: Row(
        children: [
          Container(
            width: 50, // Set the desired width
            height: 50, // Set the desired height
            child: Hero(
              tag: 'imageHero',
              child: ImageViewer.network(
                imageURL: community.imageURL,
                viewerMode: false,
                placeholderImagePath: 'images/defaults/community.png',
                width: 50,
              ),
            ),
          ),
          SizedBox(width: 8), // Add spacing between the avatar and the title
          Text(community.name),
        ],
      ),
    );
  }
}
