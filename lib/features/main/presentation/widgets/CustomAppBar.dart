import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/core/auth/User.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  CustomAppBar({
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);
  double sizeOficon = 27;
  Color iconColor = theme_darkblue.withOpacity(0.5);

  String name = user!.username ?? 'not available';
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(25, 0, 15, 0),
        height: preferredSize.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // row of profile
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/Profile'),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: theme_green,
                    radius: 21,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/download.jpeg'),
                      radius: 19,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text('$name',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          decoration: TextDecoration.none,
                          color: theme_darkblue.withOpacity(0.7))),
                ],
              ),
            ),
            // row of upper buttons
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              IconButton(
                  icon: SvgPicture.asset(
                    'images/notification.svg',
                    height: sizeOficon,
                    color: iconColor,
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, '/Notifications')),
              SizedBox(
                width: 5,
              ),
              IconButton(
                  icon: SvgPicture.asset(
                    'images/qrcode.svg',
                    height: sizeOficon,
                    color: iconColor,
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/QRcode')),
            ])
          ],
        ),
      ),
    );
  }
}
