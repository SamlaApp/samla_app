import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/presentation/pages/community_detail.dart';

class CommunityPage extends StatelessWidget {
  final Community community;
  const CommunityPage({super.key, required this.community});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: GestureDetector(
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

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

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
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(community.imageURL),
                  ),
                ),
              ),
              SizedBox(
                  width: 8), // Add spacing between the avatar and the title
              Text(community.name),
            ],
          ),
        ),
      ),
      body: Center(
        child: Text('Posts not implemented yet'),
      ),
    );
  }
}
