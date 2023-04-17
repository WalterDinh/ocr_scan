import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/ui/widgets/item_my_folder_list.dart';
import 'package:my_app/ui/widgets/item_scan_history.dart';
import 'package:my_app/ui/widgets/main_app_bar.dart';
import 'package:my_app/ui/widgets/spacer.dart';
part 'sections/empty_folder.dart';
part 'sections/list_file_scan.dart';

class ScanHistoryScreen extends StatefulWidget {
  const ScanHistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ScanHistoryScreenState();
}

class _ScanHistoryScreenState extends State<ScanHistoryScreen> {
  static const double leadingWidth = 44;

  @override
  void initState() {
    scheduleMicrotask(() async {});

    super.initState();
  }

  void _onOpenModalCreateFolder() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          isBackButtonEnabled: true,
          leadingWidth: leadingWidth,
          appBarTitleText: Text(
            'Scan history',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: AppColors.black),
          )),
      floatingActionButton: _buildFabScan(context),
      body: const ListFileScan(),
    );
  }

  Widget _buildFabScan(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: SvgPicture.asset(
            AppImages.iconScan,
            width: AppValues.iconDefaultSize,
            height: AppValues.iconDefaultSize,
            color: AppColors.lighterGrey,
          ),
          onPressed: () => _onOpenModalCreateFolder(),
        ),
      );
}
