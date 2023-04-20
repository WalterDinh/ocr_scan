import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';

const ICON_SIZE = 26.0;
const TEXT_WIDTH = 80.0;

class ItemScanFolder extends StatelessWidget {
  final String folderName;
  final Function() onPressFolder;
  final bool isAddButton;
  const ItemScanFolder(
      {super.key,
      required this.folderName,
      required this.onPressFolder,
      required this.isAddButton});

  @override
  Widget build(BuildContext context) {
    return Ripple(
      onTap: onPressFolder,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                        width: 1)),
                padding: const EdgeInsets.all(16),
                child: SvgPicture.asset(
                  isAddButton ? AppImages.iconFolderAdd : AppImages.iconFolder,
                  width: ICON_SIZE,
                  height: ICON_SIZE,
                )),
            const VSpacer(8),
            SizedBox(
                width: TEXT_WIDTH,
                child: Text(
                  folderName,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ))
          ],
        ),
      ),
    );
  }
}
