import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/data/source/local/model/file_scan.dart';
import 'package:my_app/states/folder_detail_manager/folder_detail_bloc.dart';

class FolderDetailManagerStateSelector<T>
    extends BlocSelector<FolderDetailBloc, FolderDetailManagerState, T> {
  FolderDetailManagerStateSelector({
    required T Function(FolderDetailManagerState) selector,
    required Widget Function(T) builder,
  }) : super(
          selector: selector,
          builder: (_, value) => builder(value),
        );
}

class FolderDetailManagerStatusSelector
    extends FolderDetailManagerStateSelector<FolderDetailManagerStateStatus> {
  FolderDetailManagerStatusSelector(
      Widget Function(FolderDetailManagerStateStatus) builder)
      : super(
          selector: (state) => state.status,
          builder: builder,
        );
}

class ListFileScanSelector
    extends FolderDetailManagerStateSelector<List<FileScan>> {
  ListFileScanSelector(Widget Function(List<FileScan>) builder)
      : super(
          selector: (state) => state.listFileScan,
          builder: builder,
        );
}
