import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/community/presentation/widgets/community_list.dart';
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
  final List<Map<String, dynamic>> communities = [
    {
      'name': 'KFUPM GYM',
      'description': 'Gym for KFUPM students',
      'id': 1,
      'newCounter': '0',
      'date': '7:09 PM',
    },
    {
      'name': 'GYM gamers',
      'description': 'Gym for KFUPM students',
      'id': 2,
      'newCounter': '0',
      'date': '7:09 PM',
    },
    {
      'name': 'GYM h2o',
      'description': 'Gym for KFUPM hhhhh thats not funny my son students',
      'id': 3,
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
