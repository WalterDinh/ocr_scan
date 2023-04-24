import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/data/source/local/model/file_scan.dart';
import 'package:my_app/data/source/local/model/folder.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/states/search/search_bloc.dart';
import 'package:my_app/states/search/search_selector.dart';
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
  SearchBloc get _searchBloc => context.read<SearchBloc>();
  TextEditingController controller = TextEditingController();
  String textSearch = '';
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
  }

  _handleSearch(String text) {
    setState(() {
      textSearch = text;
    });
    if (text.isNotEmpty && text.length >= 2) {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        _searchBloc.add(SearchFileAndFolderStarted(text));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
          isBackButtonEnabled: true,
          leadingWidth: leadingWidth,
          appBarTitleText: Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 24, 16),
            child: SearchInput(
              controller: controller,
              onChangeText: _handleSearch,
              hintText: 'Search...',
            ),
          ),
        ),
        body: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          if (state.status == SearchStateStatus.loading ||
              textSearch != controller.text) {
            return SpinKitFadingCircle(color: Theme.of(context).primaryColor);
          }

          if (state.listRecent.isEmpty && textSearch == '') {
            return DefaultSearchView(context: context);
          }
          if (state.listRecent.isNotEmpty && textSearch == '') {
            return RecentSearch(
              context: context,
              onPressRecent: (text) {
                _handleSearch(text);
                controller.text = text;
              },
            );
          }
          if (state.listFileScanDataSearch.isEmpty &&
              state.listFolderDataSearch.isEmpty) {
            return EmptyDataSearch(context: context);
          }

          return const ResultSearch();
        }));
  }
}
