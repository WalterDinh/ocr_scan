import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/data/source/local/model/folder.dart';
import 'package:my_app/states/folder_manager/folder_manager_bloc.dart';

class FolderManagerStateSelector<T>
    extends BlocSelector<FolderManagerBloc, FolderManagerState, T> {
  FolderManagerStateSelector({
    required T Function(FolderManagerState) selector,
    required Widget Function(T) builder,
  }) : super(
          selector: selector,
          builder: (_, value) => builder(value),
        );
}

class FolderManagerStatusSelector
    extends FolderManagerStateSelector<FolderManagerStateStatus> {
  FolderManagerStatusSelector(Widget Function(FolderManagerStateStatus) builder)
      : super(
          selector: (state) => state.status,
          builder: builder,
        );
}

class ListFolderSelector extends FolderManagerStateSelector<List<Folder>> {
  ListFolderSelector(Widget Function(List<Folder>) builder)
      : super(
          selector: (state) => state.listFolder,
          builder: builder,
        );
}
