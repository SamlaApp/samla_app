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
  Color iconColor = themeDarkBlue.withOpacity(0.5);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  decoration: TextDecoration.none,
                  color: themeDarkBlue.withOpacity(1))),
          backgroundColor: primary_color,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: themeDarkBlue.withOpacity(0.5),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}
