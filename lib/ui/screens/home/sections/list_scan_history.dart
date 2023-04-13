part of '../home.dart';

class ListScanHistory extends StatelessWidget {
  const ListScanHistory({
    super.key,
    required List<int> listScanHistory,
  }) : _listScanHistory = listScanHistory;

  final List<int> _listScanHistory;

  _onEdit() {}

  _onShare() {}

  _onShowMoreOptions() {}

  @override
  Widget build(BuildContext context) => Expanded(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _listScanHistory.length,
              itemBuilder: (context, index) {
                return ItemScanHistory(
                  onPressItem: () {},
                  dateTime: '12-9-1999',
                  fileName: '123123',
                  onEdit: _onEdit,
                  onShare: _onShare,
                  onShowMoreOption: _onShowMoreOptions,
                  pathUrl: '',
                );
              },
            )),
      );
}
