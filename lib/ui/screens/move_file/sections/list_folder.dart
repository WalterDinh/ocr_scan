part of '../move_file.dart';

class ListScanFolder extends StatefulWidget {
  const ListScanFolder({
    super.key,
  });

  @override
  State<ListScanFolder> createState() => _ListScanFolderState();
}

class _ListScanFolderState extends State<ListScanFolder> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: ListFolderSelector((data) => ListView.builder(
              itemBuilder: (context, index) {
                return ItemFolderList(
                    folderName: data[index].title, onPressFolder: () {});
              },
              itemCount: data.length,
            )));
  }

  // void _scrollListener() {
  // return;
  // print(controller.position.extentAfter);
  // if (controller.position.extentAfter < 500) {
  //   setState(() {
  //     items.addAll(List.generate(42, (index) => 'Inserted folder $index'));
  //   });
  // }
  // }
}
