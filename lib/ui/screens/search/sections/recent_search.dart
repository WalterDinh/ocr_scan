part of '../search.dart';

class RecentSearch extends StatelessWidget {
  const RecentSearch({
    super.key,
    required this.context,
    required this.onPressRecent,
  });

  final BuildContext context;
  final Function(String) onPressRecent;
  @override
  Widget build(BuildContext context) {
    return ListSearchHistorySelector((data) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Recent',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: AppColors.grey),
              ),
            ),
            Column(
              children: data
                  .map((e) => ItemResentSearch(
                        onPress: () => onPressRecent(e.textSearch),
                        title: e.textSearch,
                      ))
                  .toList(),
            ),
          ],
        ));
  }
}
