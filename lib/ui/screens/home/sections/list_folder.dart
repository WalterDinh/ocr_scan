part of '../home.dart';

double listHeight = 86.0;

class ListScanFolder extends StatelessWidget {
  const ListScanFolder({
    super.key,
    required this.listScanFolder,
    required this.onCreateFolder,
  });

  final List<Folder> listScanFolder;
  final Function() onCreateFolder;
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
      child: SizedBox(
        height: listHeight,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listScanFolder.length,
          itemBuilder: (context, index) {
            bool isAddButton = index == 0;

            return ItemScanFolder(
              isAddButton: isAddButton,
              folderName:
                  isAddButton ? 'Create new' : listScanFolder[index].title,
              onPressFolder: isAddButton ? onCreateFolder : () {},
            );
          },
        ),
      ));
}
