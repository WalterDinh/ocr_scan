import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/ui/screens/home/widgets/search_input.dart';
import 'package:my_app/ui/widgets/item_scan_folder.dart';
import 'package:my_app/ui/widgets/item_scan_history.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';

import '../../widgets/main_app_bar.dart';
part 'sections/list_folder.dart';
part 'sections/list_scan_history.dart';

class HomeScreen extends StatelessWidget {
  final _listScanFolder = [1, 2, 3, 4, 5, 6, 7];
  final _listScanHistory = [1, 2, 3, 4, 5];

  HomeScreen({super.key});

  _onFabScanPressed() {
    AppNavigator.push(Routes.select_photo);
  }

  _onPressInputSearch() {
    AppNavigator.push(Routes.search);
  }

  _onNavigateToMyFolder() {
    AppNavigator.push(Routes.my_folder);
  }

  _onNavigateToScanHistory() {
    AppNavigator.push(Routes.scan_history);
  }

  _onNavigateToSetting() {
    AppNavigator.push(Routes.setting);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHomeAppBar(context),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchInput(
              hintText: 'Search...',
              onPressInput: _onPressInputSearch,
            ),
          ),
          _buildSectionHeader('My scan folder', _onNavigateToMyFolder, context),
          ListScanFolder(listScanFolder: _listScanFolder),
          _buildSectionHeader(
              'Scan history', _onNavigateToScanHistory, context),
          ListScanHistory(
            listScanHistory: _listScanHistory,
          )
        ],
      ),
      floatingActionButton: _buildFabScan(context),
    );
  }

  PreferredSizeWidget _buildHomeAppBar(BuildContext context) => MainAppBar(
        actions: [
          IconButton(
              onPressed: _onNavigateToSetting,
              icon: const Icon(
                Icons.settings,
                size: AppValues.iconSize_22,
                color: AppColors.black,
              )),
          const HSpacer(8)
        ],
        isBackButtonShowed: false,
      );

  Widget _buildSectionHeader(
          String title, Function() onPress, BuildContext context) =>
      Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title, style: Theme.of(context).textTheme.labelLarge),
                Ripple(
                  onTap: onPress,
                  child: Text("See more",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: AppColors.semiGrey)),
                ),
              ]));

  Widget _buildFabScan(BuildContext context) {
    double paddingBottomFloadButton =
        16 + MediaQuery.of(context).viewPadding.bottom;

    return Padding(
        padding: EdgeInsets.only(bottom: paddingBottomFloadButton),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: SvgPicture.asset(
            AppImages.iconScan,
            width: AppValues.iconDefaultSize,
            height: AppValues.iconDefaultSize,
          ),
          onPressed: () => _onFabScanPressed(),
        ));
  }
}
