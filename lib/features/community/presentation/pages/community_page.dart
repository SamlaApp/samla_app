import 'dart:io';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'package:samla_app/core/network/samlaAPI.dart';
import 'package:samla_app/core/widgets/CustomTextFormField.dart';
import 'package:samla_app/core/widgets/image_viewer.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/community/community_di.dart';
import 'package:samla_app/features/community/domain/entities/Comment.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/domain/entities/Post.dart';
import 'package:samla_app/features/community/presentation/cubits/AddComment/add_comment_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/CRUDPostCubit/crud_post_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/GetPosts/get_posts_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/PostCubit/post_cubit.dart';
import 'package:samla_app/features/community/presentation/pages/community_detail.dart';

// ignore: must_be_immutable
class CommunityPage extends StatefulWidget {
  Community community;

  CommunityPage({super.key, required this.community});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  late Community community;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    community = widget.community;
  }

  void updateNameAndImageCallback(String newName, String? imageURL) {
    setState(() {
      community = community.copyWith(name: newName, imageURL: imageURL);
    });
  }

  // ignore: non_constant_identifier_names
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
            backgroundColor: themeDarkBlue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: const Icon(Icons.add, color: themeBlue, size: 30),
          ),
          appBar: AppBar(
            toolbarHeight: 60,
            backgroundColor: themeDarkBlue.withOpacity(0.95),
            titleSpacing: 0,
            // leadingWidth: 35,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: titleWidget(context, updateNameAndImageCallback),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: themeBlue.withOpacity(1),
                height: 2.0,
              ),
            ),
          ),
          body: BlocBuilder<GetPostsCubit, GetPostsState>(
            bloc: sl.get<GetPostsCubit>()..getPosts(community.id!),
            builder: (context, state) {
              if (state is GetPostsLoading) {
                return const Center(
                    child: CircularProgressIndicator(
                        color: themeBlue, backgroundColor: themePink));
              }

              if (state is GetPostsLoaded) {
                if (state.posts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.post_add_rounded,
                            size: 75, color: themeBlue),
                        Text('No posts yet',
                            style: TextStyle(
                                color: themeDarkBlue.withOpacity(0.7),
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  );
                }
                return Container(
                  color: white,
                  child: ListView(
                    children: [
                      () {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            return postWidget(state.posts[index]);
                          },
                        );
                      }()
                    ],
                  ),
                );
              }
              return const Center(child: Text('Something went wrong'));
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
        backgroundColor: themeDarkBlue,
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.0),
                        ),
                        color: white,
                      ),
                      child: Column(
                        children: [
                          ImageViewer.empty(
                            width: 450,
                            height: 300,
                            isRectangular: true,
                            editableCallback: (newImage) {
                              image = newImage;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            controller: textController,
                            iconData: Icons.text_fields_rounded,
                            label: 'Post description',
                            textAreaLike: true,
                          ),
                          const SizedBox(height: 20),
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
                                              color: themeDarkBlue
                                                  .withOpacity(0.95))),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 40,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: themeBlue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
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
                                              color: white.withOpacity(0.95))),
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

  Widget postWidget(Post post) {
    final controller = ExpandableController(initialExpanded: false);
    final commentController = TextEditingController();
    final cubit = sl.get<PostCubit>();
    final commentCubit = sl.get<AddCommentCubit>();
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
              controller.toggle();
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(20.0, 10, 20, 0),
              decoration: primaryDecoration,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ImageViewer.network(
                        imageURL: post.writerImageURL,
                        viewerMode: false,
                        placeholderImagePath: 'images/defaults/user.png',
                        width: 30,
                      ),
                      const SizedBox(width: 10),
                      Text('${post.writerName}',
                          style: TextStyle(
                              color: themeDarkBlue.withOpacity(0.7),
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
                  Text(
                    post.content ?? 'this a dummy content for this post',
                    style: TextStyle(
                        fontSize: 14, color: themeDarkBlue.withOpacity(0.6)),
                  ),
                  const SizedBox(height: 20),

                  Center(
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: themeDarkBlue.withOpacity(0.7),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          expanded: BlocBuilder<AddCommentCubit, AddCommentState>(
            bloc: commentCubit,
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.fromLTRB(30.0, 0, 30, 0),

                // rounded corners from bottom only
                decoration: const BoxDecoration(
                  color: inputFieldColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: commentsList(state, context, post, commentController,
                    commentCubit, cubit),
                // child: Container(),
              );
            },
          ),
        );
      },
    );
  }

  Container commentsList(
      AddCommentState state,
      BuildContext context,
      Post post,
      TextEditingController commentController,
      AddCommentCubit commentCubit,
      PostCubit cubit) {
    return Container(
      child: () {

        if (state is AddCommentError) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          });
        }

        if (state is AddCommentSuccess) {
          post.comments.add(state.comment);
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Comment added successfully'),
              ),
            );
          });
        }
        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: post.comments.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const SizedBox(height: 10);
            }
            index -= 1; // to skip the first item
            if (index != post.comments.length) {
              return commentWidget(post.comments[index]);
            }
            return Container(
              padding: const EdgeInsets.all(8.0),
              // height: 100,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      label: 'write a comment',
                      iconData: Icons.comment,
                      controller: commentController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      final comment = Comment(
                        communityID: community.id!,
                        writerID: int.parse(userID),
                        content: commentController.text,
                        postID: post.postID!,
                        writerName: authBloc.user.name,
                      );
                      commentCubit.addComment(comment);
                      cubit.emit(PostInitial());
                    },
                    icon: const Icon(Icons.send),
                    color: themeDarkBlue
                  )
                ],
              ),
            );
          },
        );
      }(),
    );
  }

  Widget commentWidget(Comment comment) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      decoration: primaryDecoration,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ImageViewer.network(
                  imageURL: comment.writerImageURL,
                  viewerMode: false,
                  placeholderImagePath: 'images/defaults/user.png',
                  width: 30,
                ),
                const SizedBox(width: 10),
                Text('${comment.writerName}',
                    style: TextStyle(
                        color: themeDarkBlue.withOpacity(0.7),
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ],
            ),


            const SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  child: Text(
                    comment.content,
                    style: TextStyle(
                        fontSize: 14, color: themeDarkBlue.withOpacity(0.6)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector titleWidget(
      BuildContext context, Function(String name, String? imageURL) callback) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                CommunityDetail(
                    community: community, updateNameAndImageCallback: callback),
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
          SizedBox(
            width: 40, // Set the desired width
            height: 40, // Set the desired height
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
          const SizedBox(
              width: 8), // Add spacing between the avatar and the title
          Text(community.name,
              style: const TextStyle(
                  color: white,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none)),
        ],
      ),
    );
  }
}
