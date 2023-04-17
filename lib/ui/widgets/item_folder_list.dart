import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';

const ICON_SIZE = 33.0;

class ItemFolderList extends StatelessWidget {
  final String folderName;
  final Function() onPressFolder;
  const ItemFolderList({
    super.key,
    required this.folderName,
    required this.onPressFolder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Ripple(
          onTap: onPressFolder,
          child: Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.whiteGrey))),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppImages.iconFolder,
                  width: ICON_SIZE,
                  height: ICON_SIZE,
                ),
                const HSpacer(12),
                Text(
                  folderName,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                )
              ],
            ),
          )),
    );
  }
}
