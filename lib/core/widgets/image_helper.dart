import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'dart:io';

class ImageHelper {
  final ImageCropper _imageCropper;
  ImageHelper({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imageCropper = imageCropper ?? ImageCropper();

  Future<String?> _pickImage(
      {required ImageSource source, int imageQuality = 100}) async {
    final pickedImage = await ImagePicker()
        .pickImage(source: source, imageQuality: imageQuality);
    final compressed = await compressFile(File(pickedImage!.path));
    return compressed == null ? '' : compressed.path;
  }



  // crop image
  Future<CroppedFile?> crop({
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
            toolbarColor: themeDarkBlue,
            toolbarWidgetColor: Colors.white,
            statusBarColor: themeDarkBlue,
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
      {int? imageQualtiy,
      CropAspectRatio? aspectRatio,
      CropStyle? cropStyle,
      int? maxWidth}) async {
    //show bottom sheet
    showModalBottomSheet(
        backgroundColor: themeDarkBlue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (context) {
          return SizedBox(
            height: 200,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final imagePath = await _pickImage(
                                source: ImageSource.camera,
                                imageQuality: imageQualtiy ?? 100);

                            if (imagePath != null && imagePath.isNotEmpty) {
                              final croppedFile = await crop(
                                  imagePath: imagePath,
                                  aspectRatio: aspectRatio,
                                  cropStyle: cropStyle,
                                  maxWidth: maxWidth);
                              if (croppedFile != null) {
                                onImageSelected(File(croppedFile.path));
                              }
                            }
                            Navigator.of(context)
                                .pop(); // Close the bottom sheet
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.camera,
                                  color: themeBlue,
                                  size: 60,
                                ),
                                Text('Camera',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        decoration: TextDecoration.none)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final imagePath = await _pickImage(
                                source: ImageSource.gallery,
                                imageQuality: imageQualtiy ?? 100);

                            if (imagePath != null && imagePath.isNotEmpty) {
                              final croppedFile = await crop(
                                  imagePath: imagePath,
                                  aspectRatio: aspectRatio,
                                  cropStyle: cropStyle,
                                  maxWidth: maxWidth);

                              if (croppedFile != null) {
                                onImageSelected(File(croppedFile.path));
                              }
                            }
                            Navigator.of(context)
                                .pop(); // Close the bottom sheet
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.image,
                                    color: themeBlue,
                                    size: 60,
                                  ),
                                  Text(
                                    'Gallery',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        decoration: TextDecoration.none),
                                  ),
                                ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
Future<XFile?> compressFile(File file) async {
  final filePath = file.absolute.path;

  // Create output file path
  // eg:- "Volume/VM/abcd_out.jpeg"
  final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
  final splitted = filePath.substring(0, (lastIndex));
  final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    outPath,
    quality: 25,
  );

  return result;
}
final imageHelper = ImageHelper();
