import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/core/auth/User.dart';

class buildAAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  buildAAppBar({
    this.height = kToolbarHeight,
  });

  final user = LocalAuth.user;

  @override
  Size get preferredSize => Size.fromHeight(height);
  double sizeOficon = 27;
  Color iconColor = theme_darkblue.withOpacity(0.5);

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
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  Container(
                    child: Image(
                      image: AssetImage('images/Logo/1x/Icon_1@1x.png'),
                      height: 50,
                      width: 50,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text('SAMLAH',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          decoration: TextDecoration.none,
                          color: theme_darkblue.withOpacity(1))),
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
