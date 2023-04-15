import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/ui/screens/home/widgets/search_input.dart';
import 'package:my_app/ui/screens/search/widgets/item_recent_search.dart';
import 'package:my_app/ui/screens/search/widgets/item_search.dart';
import 'package:my_app/ui/widgets/main_app_bar.dart';
import 'package:my_app/ui/widgets/spacer.dart';

part 'sections/empty_data_search.dart';
part 'sections/result_search.dart';
part 'sections/recent_search.dart';
part 'sections/default_search_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const double leadingWidth = 44;

  @override
  void initState() {
    scheduleMicrotask(() async {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        isBackButtonEnabled: true,
        leadingWidth: leadingWidth,
        appBarTitleText: const Padding(
          padding: EdgeInsets.fromLTRB(0, 16, 24, 16),
          child: SearchInput(
            hintText: 'Search...',
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [DefaultSearchView(context: context)],
        ),
      ),
    );
  }
}
