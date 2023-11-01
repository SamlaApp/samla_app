import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samla_app/config/themes/common_styles.dart';

class ImageHelper {
  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;
  ImageHelper({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  Future<String?> _pickImage(
      {required ImageSource source, int imageQuality = 50}) async {
    final pickedImage = await ImagePicker()
        .pickImage(source: source, imageQuality: imageQuality);
    return pickedImage == null ? '' : pickedImage.path;
  }

  // crop image
  Future<CroppedFile?> _crop({
    required String imagePath,
    CropAspectRatio? aspectRatio,
    CropStyle? cropStyle,
    int? maxWidth = 600,
    int? maxHeight = 600,
    bool cropAspectRatioLocked = true,
    // required BuildContext context,
  }) async {
    final croppedFile = await _imageCropper.cropImage(
      
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: theme_darkblue,
            toolbarWidgetColor: Colors.white,
            statusBarColor: theme_darkblue,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: cropAspectRatioLocked),
        IOSUiSettings(
          title: 'Cropper',
        ),
        // WebUiSettings(
        //   // context: context,
        // ),
      ],
      sourcePath: imagePath,
      aspectRatio: aspectRatio ?? const CropAspectRatio(ratioX: 1, ratioY: 1),
      cropStyle: cropStyle ?? CropStyle.rectangle,
      maxWidth: maxWidth,
    );
    return croppedFile;
  }

  pickImage(BuildContext context, Function(File) onImageSelected,
      [int? imageQualtiy,
      CropAspectRatio? aspectRatio,
      CropStyle? cropStyle,
      int? maxWidth]) async {
    //show bottom sheet
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () async {
                  final imagePath = await _pickImage(
                      source: ImageSource.camera,
                      imageQuality: imageQualtiy ?? 100);

                  if (imagePath != null) {
                    final croppedFile = await _crop(
                        imagePath: imagePath,
                        aspectRatio: aspectRatio,
                        cropStyle: cropStyle,
                        maxWidth: maxWidth);
                    if (croppedFile != null) {
                      onImageSelected(File(croppedFile.path));
                    }
                  }
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Gallery'),
                onTap: () async {
                  final imagePath = await _pickImage(
                      source: ImageSource.gallery,
                      imageQuality: imageQualtiy ?? 100);

                  if (imagePath != null) {
                    final croppedFile = await _crop(
                        imagePath: imagePath,
                        aspectRatio: aspectRatio,
                        cropStyle: cropStyle,
                        maxWidth: maxWidth);

                    if (croppedFile != null) {
                      onImageSelected(File(croppedFile.path));
                    }
                  }
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
              ),
            ],
          );
        });
  }
}
