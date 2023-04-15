part of '../search.dart';

class RecentSearch extends StatelessWidget {
  const RecentSearch({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        ItemResentSearch(
          onPress: () {
            return;
          },
          title: 'File 123',
        ),
        ItemResentSearch(
          onPress: () {
            return;
          },
          title: 'File 123',
        ),
      ],
    );
  }
}
