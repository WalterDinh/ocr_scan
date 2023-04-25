part of '../detail_folder.dart';

class ListFileScan extends StatefulWidget {
  const ListFileScan({
    super.key,
    required this.listFile,
    required this.onHandleOptions,
    required this.onEdit,
  });
  final List<FileScan> listFile;
  final Function(HistoryOptionType, FileScan) onHandleOptions;
  final Function(FileScan) onEdit;

  @override
  State<ListFileScan> createState() => _ListFileScanState();
}

_onShare(String data) {
  PdfApi.shareDocument(data);
}

_onNavigateToDetail(FileScan file) {
  AppNavigator.push(Routes.file_detail, file);
}

class _ListFileScanState extends State<ListFileScan> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            FileScan itemData = widget.listFile[index];

            return ItemScanHistory(
              onPressOption: (type) => widget.onHandleOptions(type, itemData),
              onPressItem: () => _onNavigateToDetail(itemData),
              dateTime: '${itemData.size} ${itemData.createDate}',
              fileName: 'Scan documents',
              onEdit: () => widget.onEdit(itemData),
              onShare: () => _onShare(itemData.dataText),
              pathUrl: '',
            );
          },
          itemCount: widget.listFile.length,
        ),
      ),
    );
  }
}
