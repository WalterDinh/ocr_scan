import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';

class ItemResentSearch extends StatelessWidget {
  const ItemResentSearch(
      {super.key, required this.title, required this.onPress});
  final String title;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Ripple(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              AppImages.iconSearch,
              width: AppValues.iconSize_18,
              height: AppValues.iconSize_18,
              color: AppColors.black,
            ),
            const HSpacer(8),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
