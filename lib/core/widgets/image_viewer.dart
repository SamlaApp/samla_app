import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/core/widgets/image_helper.dart';

enum ImageViewerType { network, asset, file, empty }

class ImageViewer extends StatefulWidget {
  String? imageURL;
  String? assetImagePath;
  String? placeholderImagePath;
  bool isRectangular;
  double width;
  double height;
  bool viewerMode;
  File? imageFile;
  Function(File)? editableCallback;
  String? title;
  String? animationTag;
  ImageViewerType type;

  ImageViewer.network(
      {super.key,
      this.imageURL,
      this.isRectangular = false,
      this.width = 100,
      this.height = 100,
      this.viewerMode = true,
      this.title,
      this.editableCallback,
      this.placeholderImagePath,
      this.animationTag})
      : type = ImageViewerType.network;

  ImageViewer.asset(
      {super.key,
      this.assetImagePath,
      this.isRectangular = false,
      this.width = 100,
      this.height = 100,
      this.viewerMode = true,
      this.title,
      this.editableCallback,
      this.animationTag})
      : type = ImageViewerType.asset;

  ImageViewer.file(
      {super.key,
      this.imageFile,
      this.isRectangular = false,
      this.viewerMode = true,
      this.width = 100,
      this.height = 100,
      this.title,
      this.editableCallback,
      this.animationTag})
      : type = ImageViewerType.file;

  ImageViewer.empty({
    super.key,
    this.isRectangular = false,
    this.viewerMode = true,
    this.width = 100,
    this.height = 100,
    this.title,
    this.editableCallback,
    this.animationTag,
  }) : type = ImageViewerType.empty;

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

    final imageWidget = () {
      if (image != null) {
        return ClipOval(child: Image.file(image!));
      }
      if (widget.type == ImageViewerType.network && widget.imageURL != null) {
        return ClipOval(
            child: cachedNetworkImage(
                widget.imageURL!, widget.placeholderImagePath));
      } else if (widget.type == ImageViewerType.asset &&
          widget.assetImagePath != null) {
        return ClipOval(child: Image.asset(widget.assetImagePath!));
      } else if (widget.type == ImageViewerType.file &&
          widget.imageFile != null) {
        return ClipOval(child: Image.file(widget.imageFile!));
      }
    }();

    final imageRectWidget = () {
      if (image != null) {
        return Image.file(image!);
      }
      if (widget.type == ImageViewerType.network && widget.imageURL != null) {
        return cachedNetworkImage(
            widget.imageURL!, widget.placeholderImagePath);
      } else if (widget.type == ImageViewerType.asset &&
          widget.assetImagePath != null) {
        return Image.asset(widget.assetImagePath!);
      } else if (widget.type == ImageViewerType.file &&
          widget.imageFile != null) {
        return Image.file(widget.imageFile!);
      }
    }();

    return
        // without clickable
        widget.viewerMode == false && widget.editableCallback == null
            ? widget.animationTag != null
                ? Hero(
                    tag: widget.animationTag!,
                    child: widget.isRectangular == true
                        ? RectanagularWidget(imageRectWidget)

                        // circular image
                        : CircularWidget(imageWidget),
                  )
                : widget.isRectangular == true
                    ? RectanagularWidget(imageRectWidget)

                    // circular image
                    : CircularWidget(imageWidget)
            :

            // with clickable
            GestureDetector(
                child: widget.animationTag != null
                    ? Hero(
                        tag: widget.animationTag!,
                        child: widget.isRectangular == true
                            ? RectanagularWidget(imageRectWidget)

                            // circular image
                            : CircularWidget(imageWidget),
                      )
                    : widget.isRectangular == true
                        ? RectanagularWidget(imageRectWidget)

                        // circular image
                        : CircularWidget(imageWidget),
                onTap: () {
                  if (image == null && imageWidget == null) {
                    if (widget.editableCallback != null) {
                      imageHelper.pickImage(context, (newImage) {
                        setState(() {
                          image = newImage;
                          widget.editableCallback!(newImage);
                        });
                      });
                    }
                  } else {
                    if (widget.viewerMode) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewerPage(
                              imageURL: widget.imageURL,
                              imageFile: image,
                              type: widget.type,
                              assetImagePath: widget.placeholderImagePath ??
                                  widget.assetImagePath,
                              editableCallback: widget.editableCallback != null
                                  ? (newImage) {
                                      setState(() {
                                        image = newImage;
                                        widget.editableCallback!(newImage);
                                      });
                                    }
                                  : null,
                              title: widget.title),
                        ),
                      );
                    }
                  }
                },
              );
  }

  CircleAvatar CircularWidget(ClipOval? imageWidget) {
    return CircleAvatar(
        backgroundColor: inputField_color,
        radius: widget.width / 2,
        child: imageWidget != null
            ? imageWidget
            : widget.placeholderImagePath != null
                ? ClipOval(child: Image.asset(widget.placeholderImagePath!))
                : widget.editableCallback != null
                    ? Container(
                        decoration: BoxDecoration(
                          color: inputField_color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.add_a_photo_outlined,
                            color: themeDarkBlue.withOpacity(0.3)),
                      )
                    : throw Exception(
                        'neither imageFile or imgeURL or ImageAsset or editableCallback must be passed '));
  }

  Container RectanagularWidget(Widget? imageWidget) {
    return Container(
        clipBehavior: Clip.hardEdge,
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: inputField_color,
        ),
        child: imageWidget != null
            ? FittedBox(
                child: imageWidget,
                fit: BoxFit.cover,
              )
            : widget.editableCallback != null
                ? Container(
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      color: inputField_color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.add_a_photo_outlined,
                        color: themeDarkBlue.withOpacity(0.3)),
                  )
                : widget.placeholderImagePath != null
                    ? ClipOval(child: Image.asset(widget.placeholderImagePath!))
                    : throw Exception(
                        'neither imageFile or imgeURL or ImageAsset or editableCallback must be passed '));
  }
}

class CustomCacheManager {
  static const key = 'customCacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 50,
      repo: JsonCacheInfoRepository(databaseName: key),
    ),
  );
}

Widget cachedNetworkImage(
  String imageURL,
  String? placeholderImagePath,
) {
  try {
    final widget = CachedNetworkImage(
        imageUrl: imageURL,
        cacheManager: CustomCacheManager.instance,
        fit: BoxFit.cover,
        placeholder: (context, url) => placeholderImagePath != null
            ? Image.asset(placeholderImagePath)
            : Center(child: Icon(Icons.image)),
        errorWidget: (context, url, error) => placeholderImagePath != null
            ? Image.asset(placeholderImagePath)
            : Center(child: Icon(Icons.error)),
        imageBuilder: (context, imageProvider) => Image(
              image: imageProvider,
              fit: BoxFit.cover,
            ));
    return widget;
  } catch (e) {
    print('error while load image from cache $e');
  }
  return Center();
}

class ViewerPage extends StatefulWidget {
  ViewerPage({
    super.key,
    this.imageFile,
    this.imageURL,
    this.editableCallback,
    this.title,
    this.type,
    this.assetImagePath,
  });
  String? assetImagePath;
  ImageViewerType? type;
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
    if (widget.imageFile != null && image == null) {
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
            tag: widget.imageURL ?? '',
            child: photoView(
                image, widget.imageURL, widget.assetImagePath, widget.type)),
      ),
    );
  }
}

Widget photoView(File? imageFile, String? imageURL, String? imageAssetPath,
    ImageViewerType? type) {
  if (imageFile != null) {
    return PhotoView(
      imageProvider: FileImage(imageFile!),
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.covered * 1.8,
      initialScale: PhotoViewComputedScale.contained * 1.0,
      enableRotation: false,
      backgroundDecoration: BoxDecoration(
        color: Colors.transparent,
      ),
    );
  } else if (ImageViewerType.network == type) {
    return CachedNetworkImage(
      errorWidget: (context, url, error) => PhotoView(
          imageProvider:
              AssetImage(imageAssetPath ?? 'images/defaults/empty.png'),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 1.8,
          initialScale: PhotoViewComputedScale.contained * 1.0,
          backgroundDecoration: BoxDecoration(
            color: Colors.transparent,
          )),
      imageUrl: imageURL!,
      cacheManager: CustomCacheManager.instance,
      imageBuilder: (context, imageProvider) => PhotoView(
        imageProvider: imageProvider,
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 1.8,
        initialScale: PhotoViewComputedScale.contained * 1.0,
        enableRotation: false,
        backgroundDecoration: BoxDecoration(
          color: Colors.transparent,
        ),
      ),
    );
  } else if (ImageViewerType.asset == type) {
    return PhotoView(
      imageProvider: AssetImage(imageAssetPath!),
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.covered * 1.8,
      initialScale: PhotoViewComputedScale.contained * 1.0,
      enableRotation: false,
      backgroundDecoration: BoxDecoration(
        color: Colors.transparent,
      ),
    );
  } else
    return PhotoView(
      imageProvider: AssetImage('images/defaults/empty.png'),
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.covered * 1.8,
      initialScale: PhotoViewComputedScale.contained * 1.0,
      enableRotation: false,
      backgroundDecoration: BoxDecoration(
        color: Colors.transparent,
      ),
    );
}
