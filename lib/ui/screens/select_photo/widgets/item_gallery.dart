import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/states/select_image_from_gallery/select_image_from_gallery_selector.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:photo_manager/photo_manager.dart';

class ItemGallery extends StatelessWidget {
  const ItemGallery({
    super.key,
    required this.asset,
    required this.onPress,
    required this.index,
  });

  final AssetEntity asset;
  final Function() onPress;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
            child: Ripple(
                onTap: onPress,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: AssetEntityImage(
                    asset,
                    isOriginal: false,
                    thumbnailSize: const ThumbnailSize.square(250),
                    fit: BoxFit.cover,
                  ),
                ))),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
              padding: const EdgeInsets.only(right: 5, top: 5),
              child: SelectImageFromGallerySelector(index, (_, isSelected) {
                if (isSelected) {
                  return Icon(
                    Icons.check_circle,
                    color: Theme.of(context).primaryColor,
                    size: AppValues.iconSmallSize,
                  );
                }

                return const Icon(
                  Icons.circle_outlined,
                  color: Colors.white,
                  size: AppValues.iconSmallSize,
                );
              })),
        ),
        if (asset.type == AssetType.video)
          const Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 5, bottom: 5),
              child: Icon(
                Icons.videocam,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
