import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';

class ItemSetting extends StatelessWidget {
  const ItemSetting({
    super.key,
    required this.title,
    required this.iconName,
    required this.onPress,
    this.rightView,
  });

  final String title;
  final String iconName;
  final Function() onPress;
  final Widget? rightView;
  @override
  Widget build(BuildContext context) {
    return Ripple(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
        child: Row(
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  iconName,
                  width: AppValues.iconSize_22,
                  color: Theme.of(context).primaryColor,
                  height: AppValues.iconSize_22,
                ),
                const VSpacer(20),
              ],
            ),
            const HSpacer(20),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 24),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: AppColors.whiteGrey))),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 6,
                    child: rightView ?? const HSpacer(0),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
