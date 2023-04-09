import 'package:flutter/material.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';

import '../../widgets/main_app_bar.dart';

class HomeScreen extends StatelessWidget {
  final _listScanFolder = [1, 2, 3, 4, 5, 6, 7];
  final _listScanHistory = [1, 2, 3, 4, 5];

  HomeScreen({super.key});

  PreferredSizeWidget _buildHomeAppBar(BuildContext context) => MainAppBar(
        appBarTitleText: Text('Document Scan',
            style: Theme.of(context).textTheme.headlineMedium),
        isBackButtonShowed: false,
      );

  Widget _buildSearchView() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(1, 3),
                )
              ]),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Enter keywords...'),
                Icon(Icons.search),
              ],
            ),
          ),
        ),
      );

  Widget _buildSectionScanFolderHeader(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("My scan folder", style: TextStyle(fontSize: 18)),
            Text("See more"),
          ]));

  Widget _buildListScanFolder() => Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
      child: SizedBox(
        height: 80.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _listScanFolder.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(1, 3))
                        ]),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    width: 56.0,
                    height: 56.0,
                    child: const Icon(
                      Icons.folder,
                      size: 28,
                      color: Colors.blue,
                    )),
                const VSpacer(4),
                Text("Folder ${_listScanFolder[index]}")
              ],
            );
          },
        ),
      ));

  Widget _buildSectionScanHistoryHeader(BuildContext context) => Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("Scan history", style: TextStyle(fontSize: 18)),
            Text("See more"),
          ]));

  Widget _buildListScanHistory() => Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 80.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _listScanHistory.length,
        itemBuilder: (context, index) {
          return _buildItemScanHistory(index);
        },
      ));

  Widget _buildFabScan() => FloatingActionButton(
        child: const Icon(
          Icons.document_scanner_outlined,
        ),
        onPressed: () => _onFabScanPressed(),
      );

  Widget _buildItemScanHistory(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1, 3))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                'assets/images/logo_flutter.jpg',
                width: 56,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
            _buildInfoScanHistory(index),
            Column(
              children: [
                Ripple(
                    onTap: () => _onShowMoreOptions(),
                    child: const Icon(Icons.more_vert))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoScanHistory(int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "Item ${_listScanHistory[index]}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ],
            ),
            Row(
              children: const <Widget>[
                Text(
                  "13:00  07-09-2023",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            const VSpacer(8),
            Row(
              children: <Widget>[
                Ripple(
                  onTap: () => _onDownload(),
                  child: const Icon(Icons.download),
                ),
                const HSpacer(8),
                Ripple(
                  onTap: () => _onShare(),
                  child: const Icon(Icons.share),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _onDownload() {}

  _onShare() {}

  _onShowMoreOptions() {}

  _onFabScanPressed() {
    AppNavigator.push(Routes.select_photo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHomeAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchView(),
            _buildSectionScanFolderHeader(context),
            _buildListScanFolder(),
            _buildSectionScanHistoryHeader(context),
            _buildListScanHistory()
          ],
        ),
      ),
      floatingActionButton: _buildFabScan(),
    );
  }
}
