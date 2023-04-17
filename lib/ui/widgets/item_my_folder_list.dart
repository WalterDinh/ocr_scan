import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/ui/widgets/dropdown_button_icon.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';

const ICON_SIZE = 40.0;

enum MyFolderOptionType { move, delete, rename }

List<DropdownItem> listMenu = [
  DropdownItem(
      name: 'Rename',
      tag: 'rename',
      icon: SvgPicture.asset(
        AppImages.iconEdit,
        width: AppValues.iconSize_20,
        height: AppValues.iconSize_20,
      )),
  DropdownItem(
      name: 'Move to',
      tag: 'move',
      icon: SvgPicture.asset(
        AppImages.iconMove,
        width: AppValues.iconSize_20,
        height: AppValues.iconSize_20,
      )),
  DropdownItem(
      name: 'Delete',
      tag: 'delete',
      icon: SvgPicture.asset(
        AppImages.iconDelete,
        width: AppValues.iconSize_20,
        height: AppValues.iconSize_20,
      ))
];

class ItemMyFolderList extends StatelessWidget {
  final String folderName;
  final Function() onPressFolder;
  final Function(MyFolderOptionType) onPressOption;
  final String fileNumber;
  const ItemMyFolderList({
    super.key,
    required this.folderName,
    required this.onPressFolder,
    required this.onPressOption,
    required this.fileNumber,
  });

  Function(MyFolderOptionType) _handleSelectOption(DropdownItem item) {
    switch (item.tag) {
      case 'move':
        return onPressOption(MyFolderOptionType.move);
      case 'delete':
        return onPressOption(MyFolderOptionType.delete);

      default:
        return onPressOption(MyFolderOptionType.rename);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Ripple(
        onTap: onPressFolder,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SvgPicture.asset(
            AppImages.iconFolder,
            width: ICON_SIZE,
            height: ICON_SIZE,
          ),
          const HSpacer(12),
          Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: AppColors.whiteGrey))),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              folderName,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const VSpacer(4),
                            Text(
                              '$fileNumber files',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: AppColors.semiGrey),
                            ),
                          ],
                        ),
                        PopUpMenuButtonIcon(
                          listButton: listMenu,
                          onPress: (value) => _handleSelectOption(value),
                        ),
                      ])))
        ]),
      ),
    );
  }
}
