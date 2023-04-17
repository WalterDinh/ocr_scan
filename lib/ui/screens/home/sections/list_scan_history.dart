part of '../home.dart';

class ListScanHistory extends StatelessWidget {
  const ListScanHistory({
    super.key,
    required List<int> listScanHistory,
  }) : _listScanHistory = listScanHistory;

  final List<int> _listScanHistory;

  _onEdit() {}

  _onShare() {}

  _onHandleOptions(HistoryOptionType item) {
    if (item == HistoryOptionType.move) {
      AppNavigator.push(Routes.move_file);
    }
  }

  @override
  Widget build(BuildContext context) => Expanded(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 80),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _listScanHistory.length,
              itemBuilder: (context, index) {
                return ItemScanHistory(
                  onPressOption: (item) => _onHandleOptions(item),
                  onPressItem: () {},
                  dateTime: '700 MB 04/04/2022',
                  fileName: 'Scan documents',
                  onEdit: _onEdit,
                  onShare: _onShare,
                  pathUrl: '',
                );
              },
            )),
      );
}
