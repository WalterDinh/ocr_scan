import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SearchInput(hintText: 'Search'),
            _buildSectionHeader('My scan folder', () {}),
            ListScanFolder(listScanFolder: _listScanFolder),
            _buildSectionHeader('Scan history', () {}),
            ListScanHistory(
              listScanHistory: _listScanHistory,
            )
          ],
        ),
      ),
      floatingActionButton: _buildFabScan(),
    );
  }

  PreferredSizeWidget _buildHomeAppBar(BuildContext context) => MainAppBar(
        appBarTitleText: Text('Document Scan',
            style: Theme.of(context).textTheme.headlineMedium),
        isBackButtonShowed: false,
      );

  Widget _buildSectionHeader(String title, Function() onPress) => Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title, style: const TextStyle(fontSize: 18)),
        Ripple(
          onTap: onPress,
          child: const Text("See more"),
        ),
      ]));

  Widget _buildFabScan() => FloatingActionButton(
        child: const Icon(
          Icons.document_scanner_outlined,
        ),
        onPressed: () => _onFabScanPressed(),
      );
}
