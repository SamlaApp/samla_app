import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/new_style.dart';
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
        return Container(
          color: primaryDecoration.color,
          child: SafeArea(
            child: Container(
                // decoration: primaryDecoration,
                padding: const EdgeInsets.fromLTRB(25, 0, 15, 0),
                height: preferredSize.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // row of profile
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/Logo/2x/Icon_1@2x.png',
                            width: 42,
                            height: 42,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'SAMLA',
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 24,
                                color: themeDarkBlue,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    // row of upper buttons
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      IconButton(
                          // get this icon from images carbon_chat-bot.svg
                          icon: Icon(
                            Icons.help,
                            size: sizeOfIcon,
                            color: themeDarkBlue,
                          ),
                          // go to AssistantPage(); page without pushname push
                          onPressed: () =>
                              Navigator.pushNamed(context, '/AssistantPage')),
                      IconButton(
                          icon: Icon(
                            Icons.notifications_none_outlined,
                            size: sizeOfIcon,
                            color: themeDarkBlue,
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
          ),
        );
      },
    );
  }
}
