import 'dart:io';
import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import '../../../../core/widgets/image_helper.dart';
import '../../../../core/widgets/image_viewer.dart';
import '../../../auth/domain/entities/user.dart';

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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // All fields are valid, you can create the Community object and proceed
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
            color: primary_color,
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
          title: Text("Edit Image"),
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
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
