import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:samla_app/core/widgets/image_helper.dart';

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
    print('rebuild');
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
            builder: (context) => ViewerPage(
                imageURL: widget.imageURL,
                imageFile: image ?? widget.imageFile,
                editableCallback: (newImage) {
                  setState(() {
                    image = newImage;
                    widget.editableCallback!(newImage);
                  });
                },
                title: widget.title),
          ),
        );
      },
    );
  }
}

class ViewerPage extends StatefulWidget {
  ViewerPage(
      {super.key,
      this.imageFile,
      this.imageURL,
      this.editableCallback,
      this.title});

  final String? imageURL;
  File? imageFile;
  final void Function(File)? editableCallback;
  final String? title;

  @override
  State<ViewerPage> createState() => _ViewerPageState();
}

class _ViewerPageState extends State<ViewerPage> {
  File? image;
  
  @override
  Widget build(BuildContext context) {
    if (widget.imageFile != null) {
      image = widget.imageFile;
    }
    return Scaffold(
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
                      final editedImage =
                          await imageHelper.pickImage(context, (newImage) {
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
            enableRotation: false,
            backgroundDecoration: BoxDecoration(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
