import 'package:flutter/material.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/presentation/pages/communities.dart';
import 'package:samla_app/features/community/presentation/pages/community_detail.dart';
import 'package:samla_app/features/community/presentation/pages/community_page.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String newCounter;
  final String date;
  final int communityID;
  final Community community;

  const CustomTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.newCounter,
    required this.date,
    required this.communityID,
    required this.community,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 20,
      onTap: () {
        // navigate to the community page
        Navigator.of(context).push(createRoute(
          
          community.isMemeber ? CommunityPage(community:community) : CommunityDetail(
          community:community,
        )));
      },
      // trailing: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   children: [
      //     Text(
      //       newCounter,
      //     ),
      //     SizedBox(
      //       height: 4,
      //     ),
      //     Text(
      //       date,
      //     ),
      //   ],
      // ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: Text(
          subtitle,
          style: TextStyle(fontSize: 13),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      leading:  CircleAvatar(
        backgroundImage: NetworkImage(community.imageURL),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: Text(title),
      ),
    );
  }
}

List<Widget> buildCommunitiesList(communities, bool doNotShowMyCommunities) {

  List<Widget> list = [];
  for (var community in communities) {
    // if (doNotShowMyCommunities && community.isMemeber) {
    //   continue;
    // }
    list.add(CustomTile(
      community: community,
      title: community.name,
      subtitle: community.description,
      newCounter: '0',
      date: '7:09 PM',
      communityID: community.id,
    ));
  }
  return list;
}

Route createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
