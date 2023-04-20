part of '../my_folder.dart';

class ListScanFolder extends StatefulWidget {
  const ListScanFolder({
    super.key,
    required this.onHandleOptions,
  });
  final Function(MyFolderOptionType, Folder) onHandleOptions;

  @override
  State<ListScanFolder> createState() => _ListScanFolderState();
}

class _ListScanFolderState extends State<ListScanFolder> {
  // late ScrollController controller;

  // @override
  // void initState() {
  //   super.initState();
  //   controller = ScrollController()..addListener(_scrollListener);
  // }

  // @override
  // void dispose() {
  //   controller.removeListener(_scrollListener);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListFolderSelector((data) => ListView.builder(
            itemBuilder: (context, index) {
              return ItemMyFolderList(
                fileNumber: '5',
                folderName: data[index].title,
                onPressFolder: () {},
                onPressOption: (type) =>
                    widget.onHandleOptions(type, data[index]),
              );
            },
            itemCount: data.length,
          )),
    );
  }

  // void _scrollListener() {
  //   return;
  // if (controller.position.extentAfter < 500) {
  //   setState(() {
  //     items.addAll(List.generate(42, (index) => 'Inserted folder $index'));
  //   });
  // }
  // }
}
