import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/core/auth/User.dart';

class CommunityPage extends StatefulWidget {
  CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final user = LocalAuth.user;

  final int selectedIndex = 0;

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
            padding: const EdgeInsets.all(20.0),
            child: CustomTile(title: 'KFUPM GYM',subtitle:'hello guys can you send me the schedule for the gym'),
          )
        ],
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const CustomTile({
    super.key, required this.title, required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '0',
          ),
          Text(
            '7:09 PM',
          ),
        ],
      ),
      subtitle: Text(
        subtitle
      ),
      leading: CircleAvatar(),
      title: Text(
        title
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
