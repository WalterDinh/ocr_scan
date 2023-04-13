import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/ui/widgets/dropdown_button_icon.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';

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
  final Function() onShowMoreOption;
  final Function()? onPressItem;

  const ItemScanHistory(
      {super.key,
      required this.fileName,
      required this.dateTime,
      required this.pathUrl,
      required this.onEdit,
      required this.onShare,
      required this.onShowMoreOption,
      this.onPressItem});

  @override
  Widget build(BuildContext context) {
    return Ripple(
      onTap: onPressItem,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.darkGrey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Image(
                      width: 56,
                      height: 64,
                      fit: BoxFit.cover,
                      image: AppImages.logo,
                    ),
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
                    'ca skjc cmsalkmclmasmcklasmckmsalmclkcmsamkcsakjcnsakjcasml',
                    style: Theme.of(context).textTheme.labelLarge,
                    maxLines: 2,
                  ),
                  const VSpacer(12),
                  Text(
                    dateTime,
                    style: Theme.of(context).textTheme.labelSmall,
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
          const HSpacer(20),
          PopUpMenuButtonIcon(listButton: listMenu),
        ],
      ),
    );
  }
}
