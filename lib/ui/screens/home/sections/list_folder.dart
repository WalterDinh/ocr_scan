part of '../home.dart';

double LIST_HEIGHT = 86.0;

class ListScanFolder extends StatelessWidget {
  const ListScanFolder({
    super.key,
    required List<int> listScanFolder,
  }) : _listScanFolder = listScanFolder;

  final List<int> _listScanFolder;

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
      child: SizedBox(
        height: LIST_HEIGHT,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _listScanFolder.length,
          itemBuilder: (context, index) {
            bool isAddButton = index == 0;

            return ItemScanFolder(
              isAddButton: isAddButton,
              folderName: isAddButton ? 'Create new' : 'Folder$index',
              onPressFolder: () {},
            );
          },
        ),
      ));
}
