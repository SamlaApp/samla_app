import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'package:samla_app/core/widgets/image_viewer.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart' as di;
import 'package:samla_app/features/auth/auth_injection_container.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  CustomAppBar({
    super.key,
    this.height = kToolbarHeight,
  });

  final user = sl.get<AuthBloc>().user;
  final authBloc = di.sl.get<AuthBloc>();

  @override
  Size get preferredSize => Size.fromHeight(height);
  double sizeOfIcon = 27;
  Color iconColor = themeBlue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return SafeArea(
          child: Container(
              padding: const EdgeInsets.fromLTRB(25, 0, 15, 0),
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
                          backgroundColor: Colors.white,
                          radius: 21,
                          child: ImageViewer.network(
                            imageURL:user.photoUrl,
                            width: 42,
                            height: 42,
                            placeholderImagePath: 'images/defaults/user.png',
                            viewerMode: false,
                          )
                        ),
                        const SizedBox(width: 10),
                        
                      ],
                    ),
                  ),
                  // row of upper buttons
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    IconButton(
                        icon: Icon(
                          Icons.notifications,
                          size: sizeOfIcon,
                          color: white,
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/Notifications')),
                    IconButton(
                        icon: Icon(
                          Icons.logout,
                          size: sizeOfIcon,
                          color: themePink,
                        ),
                        onPressed: () {
                          authBloc.add(LogOutEvent(context));
                        }),
                  ]),
                ],
              )),
        );
      },
    );
  }
}
