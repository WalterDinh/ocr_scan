import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/data/source/local/model/file_scan.dart';
import 'package:my_app/states/file_manager/file_manager_bloc.dart';

class FileScanManagerStateSelector<T>
    extends BlocSelector<FileScanManagerBloc, FileScanManagerState, T> {
  FileScanManagerStateSelector({
    required T Function(FileScanManagerState) selector,
    required Widget Function(T) builder,
  }) : super(
          selector: selector,
          builder: (_, value) => builder(value),
        );
}

class FileScanManagerStatusSelector
    extends FileScanManagerStateSelector<FileScanManagerStateStatus> {
  FileScanManagerStatusSelector(
      Widget Function(FileScanManagerStateStatus) builder)
      : super(
          selector: (state) => state.status,
          builder: builder,
        );
}

class ListFileScanSelector
    extends FileScanManagerStateSelector<List<FileScan>> {
  ListFileScanSelector(Widget Function(List<FileScan>) builder)
      : super(
          selector: (state) => state.listFileScan,
          builder: builder,
        );
}
