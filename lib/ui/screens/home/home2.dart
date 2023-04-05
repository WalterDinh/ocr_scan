import 'package:flutter/material.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';

class Home2Screen extends StatelessWidget {
  final _listScanFolder = [1, 2, 3, 4, 5];
  final _listScanHistory = [1, 2, 3, 4, 5];

  Home2Screen({super.key});

  Widget _buildSearchCard() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter keywords..."),
                  ),
                ),
                Icon(Icons.search),
              ],
            ),
          ),
        ),
      );

  Widget _buildSectionScanFolderHeader() => Padding(
      padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("My scan folder"),
        Text("See more"),
      ]));

  Widget _buildListScanFolder() => Padding(
      padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
      child: Container(
        height: 56.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _listScanFolder.length,
          itemBuilder: (context, index) {
            return Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                color: AppColors.pink,
                width: 56.0,
                child: Text("Item ${_listScanFolder[index]}"));
          },
        ),
      ));

  Widget _buildSectionScanHistoryHeader() => Padding(
      padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("Scan history"),
        Text("See more"),
      ]));

  Widget _buildListScanHistory() => Padding(
      padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
      child: Container(
        height: 450.0,
        child: ListView.builder(
          itemCount: _listScanHistory.length,
          itemBuilder: (context, index) {
            return _buildItemScanHistory(index);
          },
        ),
      ));

  Widget _buildFabScan() => FloatingActionButton(
      child: Icon(Icons.document_scanner_outlined),
        onPressed: () => _onFabScanPressed(),
      );

  Widget _buildItemScanHistory(int index) {
    return Card(
      color: Colors.white60,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/logo_flutter.jpg',
                width: 56,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Item 1" + index.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "13:00  07-09-2023",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    VSpacer(8),
                    Row(
                      children: <Widget>[
                        Ripple(
                          onTap: () => _onDownload(),
                          rippleColor: AppColors.semiGrey,
                          child: Icon(Icons.download),
                        ),
                        HSpacer(8),
                        Ripple(
                          onTap: () => _onShare(),
                          rippleColor: AppColors.semiGrey,
                          child: Icon(Icons.share),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Ripple(
                    onTap: () => _onShowMoreOptions(),
                    child: Icon(Icons.more_vert))
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

  _onFabScanPressed() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _buildSearchCard(),
            _buildSectionScanFolderHeader(),
            _buildListScanFolder(),
            _buildSectionScanHistoryHeader(),
            _buildListScanHistory()
          ],
        ),
        floatingActionButton: _buildFabScan(),
      ),
    );
  }
}
