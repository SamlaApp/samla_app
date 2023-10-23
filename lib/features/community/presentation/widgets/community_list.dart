import 'package:flutter/material.dart';
import 'package:samla_app/features/community/presentation/pages/communities.dart';
import 'package:samla_app/features/community/presentation/pages/community_detail.dart';
import 'package:samla_app/features/community/presentation/pages/community_page.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String newCounter;
  final String date;
  final int communityID;

  const CustomTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.newCounter,
    required this.date,
    required this.communityID,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 20,
      onTap: () {
        // navigate to the community page
        Navigator.of(context).push(createRoute(CommunityDetail(
          communityID: communityID,
        )));
      },
      trailing: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '0',
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            '7:09 PM',
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: Text(
          subtitle,
          style: TextStyle(fontSize: 13),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      leading: const CircleAvatar(),
      title: Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: Text(title),
      ),
    );
  }
}

List<Widget> buildCommunitiesList(communities) {
  List<Widget> list = [];
  for (var community in communities) {
    list.add(CustomTile(
      title: community['name'],
      subtitle: community['description'],
      newCounter: community['newCounter'],
      date: community['date'],
      communityID: community['id'],
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
