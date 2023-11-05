import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart';

import '../../../../core/network/samlaAPI.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class buildAAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  buildAAppBar({
    this.height = kToolbarHeight,
  });

  final user = getUser();

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
              FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.transparent,
                // Set background color to transparent
                // foregroundColor: Colors.white,

                onPressed: () {
                  authBloc.add(LogOutEvent(context));
                },
                child: const Text(
                  'Logout',
                  softWrap: false,
                  style: TextStyle(
                    color: Color.fromRGBO(190, 30, 34, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
