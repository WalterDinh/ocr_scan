part of '../my_folder.dart';

class ListScanFolder extends StatefulWidget {
  const ListScanFolder({
    super.key,
  });

  @override
  State<ListScanFolder> createState() => _ListScanFolderState();
}

class _ListScanFolderState extends State<ListScanFolder> {
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

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        controller: controller,
        itemBuilder: (context, index) {
          return ItemMyFolderList(
            fileNumber: '5',
            folderName: items[index],
            onPressFolder: () {},
            onPressOption: (p0) {},
          );
        },
        itemCount: items.length,
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
