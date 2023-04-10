import 'package:flutter/material.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';

const ICON_SIZE = 56.0;

class ItemScanFolder extends StatelessWidget {
  final String folderName;
  final Function() onPressFolder;

  const ItemScanFolder(
      {super.key, required this.folderName, required this.onPressFolder});

  @override
  Widget build(BuildContext context) {
    return Ripple(
      onTap: onPressFolder,
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 3))
                  ]),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              width: ICON_SIZE,
              height: ICON_SIZE,
              child: const Icon(
                Icons.folder,
                size: 28,
                color: Colors.blue,
              )),
          const VSpacer(4),
          Text(folderName)
        ],
      ),
    );
  }
}
