import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/ui/widgets/spacer.dart';

import '../../core/values/app_values.dart';

class DropdownItem {
  final String name;
  final String tag;
  final Widget icon;

  DropdownItem({required this.name, required this.tag, required this.icon});
}

class PopUpMenuButtonIcon extends StatelessWidget {
  const PopUpMenuButtonIcon(
      {super.key, required this.listButton, this.icon, required this.onPress});
  final List<DropdownItem> listButton;
  final Widget? icon;
  final Function(DropdownItem) onPress;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<DropdownItem>(
        splashRadius: AppValues.iconSize_20,
        icon: icon ??
            SvgPicture.asset(
              AppImages.iconMore,
              width: AppValues.iconSize_20,
              height: AppValues.iconSize_20,
            ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        position: PopupMenuPosition.over,
        onSelected: (value) => onPress(value),
        itemBuilder: (BuildContext context) => listButton
            .map(
              (e) => PopupMenuItem<DropdownItem>(
                value: e,
                child: Row(
                  children: [e.icon, const HSpacer(16), Text(e.name)],
                ),
              ),
            )
            .toList());
  }
}
