import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/base/pair.dart';
import 'package:my_app/states/file_detail_manager/file_detail_manager_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

class FileDetailStateSelector<T>
    extends BlocSelector<FileDetailBloc, FileDetailState, T> {
  FileDetailStateSelector({
    required T Function(FileDetailState) selector,
    required Widget Function(T) builder,
  }) : super(
          selector: selector,
          builder: (_, value) => builder(value),
        );
}

class FileDetailStateStatusSelector
    extends FileDetailStateSelector<FileDetailStateStatus> {
  FileDetailStateStatusSelector(Widget Function(FileDetailStateStatus) builder)
      : super(
          selector: (state) => state.status,
          builder: builder,
        );
}

class CurrentScanDataTextSelector extends FileDetailStateSelector<String> {
  CurrentScanDataTextSelector(Widget Function(String) builder)
      : super(
          selector: (state) => state.dataText,
          builder: builder,
        );
}

class CurrentScanDataPDFSelector extends FileDetailStateSelector<File?> {
  CurrentScanDataPDFSelector(Widget Function(File?) builder)
      : super(
          selector: (state) => state.pdfFile,
          builder: builder,
        );
}

class CurrentScanDataSelector extends FileDetailStateSelector<Pair> {
  CurrentScanDataSelector(Widget Function(Pair) builder)
      : super(
            selector: (state) => Pair(state.dataText, state.pdfFile),
            builder: builder);
}

class FileDetailSelectorState {
  final AssetEntity photo;

  const FileDetailSelectorState(this.photo);

  @override
  bool operator ==(Object other) =>
      other is FileDetailSelectorState && photo == other.photo;
}
