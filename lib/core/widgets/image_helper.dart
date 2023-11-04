import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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
        backgroundColor: primary_color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            child: Column(
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: theme_green,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20.0),
                    ),
                  ),
                ),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.camera,
                                  color: theme_green,
                                  size: 60,
                                ),
                                Text('Camera'),
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
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.image,
                                    color: theme_green,
                                    size: 60,
                                  ),
                                  Text(
                                    'Gallery',
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

final imageHelper = ImageHelper();

// Future<File> _fileFromImageUrl(String url) async {
//   final response = await http.get(Uri.parse(url));

//   final documentDirectory = await getApplicationDocumentsDirectory();

//   final file = File(join(documentDirectory.path, 'imagetest.jpg'));

//   file.writeAsBytesSync(response.bodyBytes);
//   // Delete the file after it has been assigned to the variable.
//   // await file.delete();
//   print('image downloaded');

//   return file;
// }

class ImageViewer extends StatefulWidget {
  ImageViewer(
      {super.key,
      this.imageURL,
      this.imageFile,
      this.editableCallback,
      this.title});
  final String? imageURL;
  File? imageFile;
  final Function(File)? editableCallback;
  final String? title;

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  File? image;
  @override
  Widget build(BuildContext context) {
    if (widget.imageFile != null) {
      image = widget.imageFile;
    }

    return GestureDetector(
      child: Hero(
        tag: 'imageHero',
        child: CircleAvatar(
          radius: 50,
          backgroundImage: () {
            ImageProvider? _() {
              // note that if both imageURL and imageFile passed
              // the priority will be for imageURL
              if (image != null) {
                return FileImage(image!);
              } else if (widget.imageURL != null) {
                return NetworkImage(widget.imageURL!);
              }
            }

            return _();
          }(),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                  title: Text(widget.title ?? ''),
                  elevation: 0.2,
                  backgroundColor: Colors.transparent,
                  actions: widget.editableCallback != null
                      ? [
                          IconButton(
                            // call back function to return the edited image
                            onPressed: () async {
                              final editedImage = await imageHelper
                                  .pickImage(context, (newImage) {
                                setState(() {
                                  image = newImage;
                                  widget.editableCallback!(newImage);
                                });
                              });
                            },
                            icon: Icon(Icons.edit_rounded, color: Colors.white),
                          )
                        ]
                      : null),
              body: Container(
                color: Colors.black,
                child: Hero(
                  tag: 'imageHero',
                  child: PhotoView(
                    imageProvider: () {
                      ImageProvider? _() {
                        // note that if both imageURL and imageFile passed
                        // the priority will be for imageURL
                        if (image != null) {
                          return FileImage(image!);
                        } else if (widget.imageURL != null) {
                          return NetworkImage(widget.imageURL!);
                        }
                      }

                      return _();
                    }(),
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    maxScale: PhotoViewComputedScale.covered * 1.8,
                    initialScale: PhotoViewComputedScale.contained * 1.0,
                    enableRotation: true,
                    backgroundDecoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
