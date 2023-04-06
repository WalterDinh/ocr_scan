import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:photo_manager/photo_manager.dart';

class ItemGallery extends StatelessWidget {
  const ItemGallery(
      {super.key,
      required this.asset,
      required this.data,
      required this.onPress});

  final AssetEntity asset;
  final Uint8List data;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
            child: Ripple(
          onTap: onPress,
          child: Image.memory(
            data,
            fit: BoxFit.cover,
          ),
        )),
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
