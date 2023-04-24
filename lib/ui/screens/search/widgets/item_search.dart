import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';

enum ItemSearchType { folder, file }

double fileImageWidth = 40.0;

class ItemSearch extends StatelessWidget {
  const ItemSearch(
      {super.key,
      required this.title,
      required this.type,
      required this.onPress});
  final String title;
  final ItemSearchType type;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Ripple(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                type == ItemSearchType.file
                    ? Image(
                        image: AppImages.defaultFileImage,
                        width: fileImageWidth,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SvgPicture.asset(
                          AppImages.iconFolder,
                          width: AppValues.appBarIconSize,
                        ),
                      ),
                const HSpacer(8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
            IconButton(
                splashRadius: AppValues.iconSize_20,
                onPressed: onPress,
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: AppValues.iconSize_14,
                  color: AppColors.grey,
                ))
          ],
        ),
      ),
    );
  }
}
