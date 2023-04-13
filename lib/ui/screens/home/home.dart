import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/ui/screens/home/widgets/search_input.dart';
import 'package:my_app/ui/widgets/item_scan_folder.dart';
import 'package:my_app/ui/widgets/item_scan_history.dart';
import 'package:my_app/ui/widgets/ripple.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHomeAppBar(context),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SearchInput(hintText: 'Search...'),
          _buildSectionHeader('My scan folder', () {}, context),
          ListScanFolder(listScanFolder: _listScanFolder),
          _buildSectionHeader('Scan history', () {}, context),
          ListScanHistory(
            listScanHistory: _listScanHistory,
          )
        ],
      ),
      floatingActionButton: _buildFabScan(context),
    );
  }

  PreferredSizeWidget _buildHomeAppBar(BuildContext context) => MainAppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
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
                      style: Theme.of(context).textTheme.labelSmall),
                ),
              ]));

  Widget _buildFabScan(BuildContext context) => FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: SvgPicture.asset(
          AppImages.iconScan,
          width: AppValues.iconDefaultSize,
          height: AppValues.iconDefaultSize,
        ),
        onPressed: () => _onFabScanPressed(),
      );
}
