import 'dart:io';
import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

// import 'package:image_picker/image_picker.dart';
import '../../../auth/domain/entities/user.dart';

class ProfileWidget extends StatelessWidget {
  final String imgPath;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imgPath,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(children: [
        buildImage(),
        Positioned(
          bottom: 0,
          right: 4,
          child: buildEditIcon(color),
        ),
      ]),
    );
  }

  Widget buildImage() {
    final image = Image.asset('images/download.jpeg');

    return buildCircle(
      color: theme_green,
      all: 2,
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: Ink.image(
            image: image.image,
            fit: BoxFit.cover,
            width: 110,
            height: 110,
            child: InkWell(onTap: onClicked),
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
