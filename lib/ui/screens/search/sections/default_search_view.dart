part of '../search.dart';

class DefaultSearchView extends StatelessWidget {
  const DefaultSearchView({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset(
            AppImages.iconSearchEmpty,
            width: AppValues.iconSize_64,
            height: AppValues.iconSize_64,
          ),
          const VSpacer(16),
          Text(
            'Search in contents',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const VSpacer(8),
          Text(
            'Search file names and content for\n your search terms.',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: AppColors.grey, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
