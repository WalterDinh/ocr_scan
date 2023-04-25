part of '../search.dart';

class ResultSearch extends StatelessWidget {
  const ResultSearch({
    super.key,
    this.listFolder,
    this.listFileScan,
  });
  final List<Folder>? listFolder;
  final List<FileScan>? listFileScan;

  onNavigateToFolderDetail(Folder folder) {
    AppNavigator.push(Routes.folder_detail, folder);
  }

  _onNavigateToDetail(FileScan file) {
    AppNavigator.push(Routes.file_detail, file);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
              child: Text(
                'Result',
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: AppColors.grey),
              ),
            ),
            ListFolderSelector(
              (data) {
                if (data.isEmpty) return const SizedBox();

                return Column(
                  children: data
                      .map((e) => ItemSearch(
                            onPress: () => onNavigateToFolderDetail(e),
                            title: e.title,
                            type: ItemSearchType.folder,
                          ))
                      .toList(),
                );
              },
            ),
            ListFileScanSelector((data) {
              if (data.isEmpty) return const SizedBox();

              return Column(
                children: data
                    .map((e) => ItemSearch(
                          onPress: () => _onNavigateToDetail(e),
                          title: e.title,
                          type: ItemSearchType.file,
                        ))
                    .toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
