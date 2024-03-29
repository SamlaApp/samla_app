import 'dart:io';
import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'package:samla_app/features/profile/presentation/cubit/profile_cubit.dart';
import '../../../../core/widgets/image_helper.dart';
import '../../../../core/widgets/image_viewer.dart';
import 'package:samla_app/features/profile/profile_di.dart' as di;

class FriendProfileWidget extends StatefulWidget {
  final String imageName;
  final VoidCallback onClicked;

  const FriendProfileWidget({
    Key? key,
    required this.imageName,
    required this.onClicked,
  }) : super(key: key);

  @override
  State<FriendProfileWidget> createState() => _FriendProfileWidgetState();
}

class _FriendProfileWidgetState extends State<FriendProfileWidget> {
  File? _image;
  final _formKey = GlobalKey<FormState>();

  final avatarCubit = di.sl.get<ProfileCubit>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      avatarCubit.updateAvatar(_image!);
    }
  }

  Future<void> _pickImage() async {
    final ImageHelper _imageHelper = ImageHelper();
    final imagePath = await _imageHelper.pickImage(context, (image) {
      setState(() {
        _image = image;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              buildImage(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildImage() {
    return buildCircle(
      color: Colors.transparent,
      all: 2,
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: ImageViewer.network(
            placeholderImagePath: 'images/defaults/user.png',
            imageURL: widget.imageName,
            width: 110,
            height: 110,
          ),
        ),
      ),
    );
  }

  

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

  void showImageEditor() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: white,
          title: const Text("Edit Image"),
          content: Container(
            // You can customize the size of the image viewer here
            width: double.maxFinite,
            height: 350,
            child: Form(
              key: _formKey,
              child: ImageViewer.file(
                imageFile: _image,
                editableCallback: (newImage) {
                  setState(() {
                    _image = newImage;
                  });
                },
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: themeBlue,
              ),
              onPressed: () {
                _submitForm();
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

}
