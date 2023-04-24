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
  _onNavigateToDetail(Folder folder) {
    AppNavigator.push(Routes.folder_detail, folder);
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListFolderSelector((data) => ListView.builder(
            itemBuilder: (context, index) {
              return ItemMyFolderList(
                fileNumber: '${data[index].totalFile}',
                folderName: data[index].title,
                onPressFolder: () => _onNavigateToDetail(data[index]),
                onPressOption: (type) =>
                    widget.onHandleOptions(type, data[index]),
              );
            },
            itemCount: data.length,
          )),
    );
  }
}
