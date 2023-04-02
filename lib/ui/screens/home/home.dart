import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/configs/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../states/theme/theme_cubit.dart';

part 'sections/pokemon_news.dart';
part 'sections/header_card_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  late AppLocalizations appLocalization;

  bool showTitle = false;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final offset = _scrollController.offset;
    final showTitle = offset > _HeaderCardContent.height - kToolbarHeight;

    // Prevent unneccesary rebuild
    if (this.showTitle == showTitle) return;

    setState(() {
      this.showTitle = showTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    appLocalization = AppLocalizations.of(context)!;

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            expandedHeight: _HeaderCardContent.height,
            floating: true,
            pinned: true,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            backgroundColor: AppColors.red,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              centerTitle: true,
              title: Visibility(
                visible: showTitle,
                child: Text(
                  appLocalization.bottomNavHome,
                  style: Theme.of(context)
                      .appBarTheme
                      .toolbarTextStyle!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              background: _HeaderCardContent(),
            ),
          ),
        ],
        body: Column(
          children: [
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
            )
          ],
        ),
      ),
    );
  }
}
