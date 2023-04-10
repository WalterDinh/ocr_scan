part of '../home.dart';

class ListScanHistory extends StatelessWidget {
  const ListScanHistory({
    super.key,
    required List<int> listScanHistory,
  }) : _listScanHistory = listScanHistory;

  final List<int> _listScanHistory;

  _onDownload() {}

  _onShare() {}

  _onShowMoreOptions() {}

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 80.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _listScanHistory.length,
          itemBuilder: (context, index) {
            return ItemScanHistory(
              onPressItem: () {},
              dateTime: '12-9-1999',
              fileName: '123123',
              onDownLoad: _onDownload,
              onShare: _onShare,
              onShowMoreOption: _onShowMoreOptions,
              pathUrl: '',
            );
          },
        ),
      );
}
