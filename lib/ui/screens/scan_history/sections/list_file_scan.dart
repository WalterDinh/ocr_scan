part of '../scan_history.dart';

class ListFileScan extends StatefulWidget {
  const ListFileScan({
    super.key,
  });

  @override
  State<ListFileScan> createState() => _ListFileScanState();
}

class _ListFileScanState extends State<ListFileScan> {
  late ScrollController controller;

  List<String> items = List.generate(100, (index) => 'Folder $index');

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  _onEdit() {}

  _onShare() {}

  _onHandleOptions(HistoryOptionType item) {
    if (item == HistoryOptionType.move) {
      AppNavigator.push(Routes.move_file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          controller: controller,
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
          itemCount: items.length,
        ),
      ),
    );
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 500) {
      setState(() {
        items.addAll(List.generate(42, (index) => 'Inserted folder $index'));
      });
    }
  }
}
