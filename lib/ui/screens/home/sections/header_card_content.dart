part of '../home.dart';

class _HeaderCardContent extends StatelessWidget {
  static const double height = 582;

  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
          Text(
            'Heading 1',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            'Heading 2',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            'Heading 1',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            'Body 1',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'Body 2',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            'Body 3',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              OutlinedButton(
                onPressed: null,
                child: Text('OutlinedButton'),
              ),
              TextButton(
                onPressed: null,
                child: Text('TextButton'),
              ),
              ElevatedButton(
                //Button Color is as define in theme
                onPressed: null,
                child: Text("Send"), //Text Color as define in theme
              )
            ],
          ),
        ],
      ),
    );
  }
}
