import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/ui/widgets/dropdown_button_icon.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';

enum HistoryOptionType { move, delete }

List<DropdownItem> listMenu = [
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

class ItemScanHistory extends StatelessWidget {
  final String fileName;
  final String dateTime;
  final String pathUrl;
  final Function() onEdit;
  final Function() onShare;
  final Function()? onPressItem;
  final Function(HistoryOptionType) onPressOption;

  const ItemScanHistory(
      {super.key,
      required this.fileName,
      required this.dateTime,
      required this.pathUrl,
      required this.onEdit,
      required this.onShare,
      this.onPressItem,
      required this.onPressOption});

  _handleSelectOption(DropdownItem item) {
    if (item.tag == 'move') {
      return onPressOption(HistoryOptionType.move);
    }

    return onPressOption(HistoryOptionType.delete);
  }

  @override
  Widget build(BuildContext context) {
    return Ripple(
      onTap: onPressItem,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: const Image(
                          width: 56,
                          height: 64,
                          image: AppImages.defaultFileImage,
                        ),
                      ),
                      const VSpacer(12)
                    ],
                  ),
                  _buildInfoScanHistory(context)
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoScanHistory(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.whiteGrey))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    fileName,
                    style: Theme.of(context).textTheme.labelLarge,
                    maxLines: 2,
                  ),
                  const VSpacer(12),
                  Text(
                    dateTime,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: AppColors.semiGrey),
                  ),
                ],
              ),
            )),
            _buildIconButton()
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Ripple(
            onTap: onEdit,
            child: SvgPicture.asset(
              AppImages.iconEdit,
              width: AppValues.iconSize_20,
              height: AppValues.iconSize_20,
            ),
          ),
          const HSpacer(20),
          Ripple(
            onTap: onShare,
            child: SvgPicture.asset(
              AppImages.iconShare,
              width: AppValues.iconSize_20,
              height: AppValues.iconSize_20,
            ),
          ),
          const HSpacer(4),
          PopUpMenuButtonIcon(
            listButton: listMenu,
            onPress: (value) => _handleSelectOption(value),
          ),
        ],
      ),
    );
  }
}
