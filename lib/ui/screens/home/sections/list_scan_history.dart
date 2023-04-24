part of '../home.dart';

class ListScanHistory extends StatelessWidget {
  const ListScanHistory({
    super.key,
    required List<FileScan> listScanHistory,
    required this.onDelete,
    required this.onEdit,
  }) : _listScanHistory = listScanHistory;
  final Function(FileScan) onDelete;
  final List<FileScan> _listScanHistory;
  final Function(FileScan) onEdit;

  _onShare() {}

  _onHandleOptions(HistoryOptionType item, FileScan file) {
    if (item == HistoryOptionType.move) {
      AppNavigator.push(Routes.move_file, file);
    }
    if (item == HistoryOptionType.delete) {
      onDelete(file);
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
                FileScan itemData = _listScanHistory[index];

                return ItemScanHistory(
                  onPressOption: (item) => _onHandleOptions(item, itemData),
                  onPressItem: () {},
                  dateTime: '${itemData.size} ${itemData.createDate}',
                  fileName: 'Scan documents',
                  onEdit: () => onEdit(itemData),
                  onShare: _onShare,
                  pathUrl: '',
                );
              },
            )),
      );
}
