part of '../search.dart';

class ResultSearch extends StatelessWidget {
  const ResultSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemSearch(
          onPress: () {
            return;
          },
          title: 'File 123',
          type: ItemSearchType.folder,
        ),
        ItemSearch(
          onPress: () {
            return;
          },
          title: 'File 123',
          type: ItemSearchType.file,
        )
      ],
    );
  }
}
