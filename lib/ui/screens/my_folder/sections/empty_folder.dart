part of '../my_folder.dart';

class EmptyFolder extends StatelessWidget {
  const EmptyFolder({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(
            AppImages.iconNoSearchResult,
            width: AppValues.iconSize_64,
            height: AppValues.iconSize_64,
          ),
          const VSpacer(16),
          Text(
            'You don’t have any folder',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: AppColors.grey, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Create new folder'),
            ),
          )
        ],
      ),
    );
  }
}
