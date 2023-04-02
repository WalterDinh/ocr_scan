import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/ui/widgets/image_picker/image_helper.dart';
import 'package:my_app/ui/widgets/modal.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';

class ImagePickerModal extends StatefulWidget {
  const ImagePickerModal({
    required this.onTakeImage,
  });
  final Function(CroppedFile?) onTakeImage;
  @override
  State<ImagePickerModal> createState() => _ImagePickerModalState();
}

class _ImagePickerModalState extends State<ImagePickerModal> {
  final ImageHelper imageHelper = ImageHelper();

  Future onPickFromGallery() async {
    final files = await imageHelper.pickImage();
    XFile? file = files.first;
    if (file != null) {
      final cropFile = await imageHelper.crop(file: file);
      if (cropFile != null) {
        widget.onTakeImage(cropFile);
      }
    }
  }

  Future onTakePhoto() async {
    final files = await imageHelper.pickImage(source: ImageSource.camera);
    XFile? file = files.first;
    if (file != null) {
      final cropFile = await imageHelper.crop(file: file);
      if (cropFile != null) {
        widget.onTakeImage(cropFile);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width - 24;

    return Modal(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Ripple(
                onTap: () => onTakePhoto(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.photo_camera,
                      size: AppValues.iconSize_28,
                    ),
                    HSpacer(12),
                    Text('Take photo from camera')
                  ],
                )),
            const VSpacer(16),
            Ripple(
                onTap: () => onPickFromGallery(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.image,
                      size: AppValues.iconSize_28,
                    ),
                    HSpacer(12),
                    Text('Take photo from gallery')
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
