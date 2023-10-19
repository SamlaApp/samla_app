import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/core/auth/User.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'community_page.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart' as di;


class CommunitiesPage extends StatefulWidget {
  CommunitiesPage({super.key});

  @override
  State<CommunitiesPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunitiesPage> {
  final user = di.sl.get<AuthBloc>().user;

  final int selectedIndex = 0;
  final List<Map<String, String>> communities = [
    {
      'name': 'KFUPM GYM',
      'description': 'Gym for KFUPM students',
      'id': '1',
      'newCounter': '0',
      'date': '7:09 PM',
    },
    {
      'name': 'GYM gamers',
      'description': 'Gym for KFUPM students',
      'id': '1',
      'newCounter': '0',
      'date': '7:09 PM',
    },
    {
      'name': 'GYM h2o',
      'description': 'Gym for KFUPM hhhhh thats not funny my son students',
      'id': '1',
      'newCounter': '0',
      'date': '7:09 PM',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: inputField_color,
      child: Column(
        children: [
          // search bar here
          Container(
            decoration: primary_decoration,
            padding: const EdgeInsets.all(20.0),
            child: const Column(
              // search field
              children: [
                CustomTextField(
                    label: 'Search for a community', iconData: Icons.search)
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),

          Container(
              decoration: primary_decoration,
              padding: const EdgeInsets.all(5.0),
              child: Column(children: buildCommunitiesList(communities)))
        ],
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

class CustomTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String newCounter;
  final String date;
  final String communityID;

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
        Navigator.of(context).push(createRoute(CommunityPage(
          communityID: communityID,
          communityName: title,
        )));
      },
      trailing: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '0',
          ),
          SizedBox(height: 4,),
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

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData iconData;
  const CustomTextField({
    super.key,
    required this.label,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: theme_darkblue.withOpacity(0.3),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: inputField_color,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        labelText: label,
        labelStyle: TextStyle(color: inputField_color.withOpacity(0.3)),
        prefixIcon: Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: Icon(
            iconData,
            color: theme_darkblue.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
