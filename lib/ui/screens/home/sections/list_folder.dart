part of '../home.dart';

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
        height: 80.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _listScanFolder.length,
          itemBuilder: (context, index) {
            return ItemScanFolder(
              folderName: 'Folder$index',
              onPressFolder: () {},
            );
          },
        ),
      ));
}
