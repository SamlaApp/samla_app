import 'package:flutter/material.dart';
import 'package:samla_app/core/widgets/image_viewer.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/presentation/pages/communities.dart';
import 'package:samla_app/features/community/presentation/pages/community_detail.dart';
import 'package:samla_app/features/community/presentation/pages/community_page.dart';
import 'package:samla_app/features/community/presentation/widgets/route_transition.dart';

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
      leading:  ImageViewer.network(
        imageURL: community.imageURL,
        viewerMode: false,
        placeholderImagePath: 'images/defaults/community.png',
        width: 50,
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


