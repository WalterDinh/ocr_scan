import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/data/source/local/model/file_scan.dart';
import 'package:my_app/data/source/local/model/folder.dart';
import 'package:my_app/data/source/local/model/search_history.dart';
import 'package:my_app/states/search/search_bloc.dart';

class SearchStateSelector<T> extends BlocSelector<SearchBloc, SearchState, T> {
  SearchStateSelector({
    required T Function(SearchState) selector,
    required Widget Function(T) builder,
  }) : super(
          selector: selector,
          builder: (_, value) => builder(value),
        );
}

class FolderDetailManagerStatusSelector
    extends SearchStateSelector<SearchStateStatus> {
  FolderDetailManagerStatusSelector(Widget Function(SearchStateStatus) builder)
      : super(
          selector: (state) => state.status,
          builder: builder,
        );
}

class ListFileScanSelector extends SearchStateSelector<List<FileScan>> {
  ListFileScanSelector(Widget Function(List<FileScan>) builder)
      : super(
          selector: (state) => state.listFileScanDataSearch,
          builder: builder,
        );
}

class ListFolderSelector extends SearchStateSelector<List<Folder>> {
  ListFolderSelector(Widget Function(List<Folder>) builder)
      : super(
          selector: (state) => state.listFolderDataSearch,
          builder: builder,
        );
}

class ListSearchHistorySelector
    extends SearchStateSelector<List<SearchHistory>> {
  ListSearchHistorySelector(Widget Function(List<SearchHistory>) builder)
      : super(
          selector: (state) => state.listRecent,
          builder: builder,
        );
}
