import 'dart:io';
import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'package:samla_app/features/profile/presentation/cubit/profile_cubit.dart';
import '../../../../core/widgets/image_helper.dart';
import '../../../../core/widgets/image_viewer.dart';
import 'package:samla_app/features/profile/profile_di.dart' as di;

class ProfileWidget extends StatefulWidget {
  final String imageName;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imageName,
    required this.onClicked,
  }) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
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
              Positioned(
                bottom: 0,
                right: 4,
                child: GestureDetector(
                  onTap: () {
                    showImageEditor();
                  },
                  child: buildEditIcon(color),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildImage() {
    final imageApi = 'https://samla.mohsowa.com/api/user/user_photo/';

    return buildCircle(
      color: themeBlue,
      all: 2,
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: Image.network(
            imageApi + widget.imageName,
            fit: BoxFit.cover,
            width: 110,
            height: 110,
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: themeBlue,
        all: 3,
        child: buildCircle(
          color: themeBlue,
          all: 8,
          child: Icon(
            Icons.edit,
            color: primaryColor,
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

  void showImageEditor() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Image"),
          content: Container(
            // You can customize the size of the image viewer here
            width: double.maxFinite,
            height: 400,
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
