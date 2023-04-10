
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/states/scan_photo/scan_photo_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

class ScanPhotoStateSelector<T>
    extends BlocSelector<ScanPhotoBloc, ScanPhotoState, T> {
  ScanPhotoStateSelector({
    required T Function(ScanPhotoState) selector,
    required Widget Function(T) builder,
  }) : super(
          selector: selector,
          builder: (_, value) => builder(value),
        );
}

class ScanPhotoStateStatusSelector
    extends ScanPhotoStateSelector<ScanPhotoStateStatus> {
  ScanPhotoStateStatusSelector(Widget Function(ScanPhotoStateStatus) builder)
      : super(
          selector: (state) => state.status,
          builder: builder,
        );
}

class ScanPhotoCanLoadMoreSelector extends ScanPhotoStateSelector<bool> {
  ScanPhotoCanLoadMoreSelector(Widget Function(bool) builder)
      : super(
          selector: (state) => state.canLoadMore,
          builder: builder,
        );
}

class NumberOfScanPhotosSelector extends ScanPhotoStateSelector<int> {
  NumberOfScanPhotosSelector(Widget Function(int) builder)
      : super(
          selector: (state) => state.mediaList.length,
          builder: builder,
        );
}

class CurrentScanPhotoSelector extends ScanPhotoStateSelector<AssetEntity?> {
  CurrentScanPhotoSelector(Widget Function(AssetEntity?) builder)
      : super(
          selector: (state) => state.selectedPhoto,
          builder: builder,
        );
}

class ScanPhotoSelector extends ScanPhotoStateSelector<ScanPhotoSelectorState> {
  ScanPhotoSelector(int index, Widget Function(AssetEntity) builder)
      : super(
          selector: (state) => ScanPhotoSelectorState(state.mediaList[index]),
          builder: (value) => builder(value.photo),
        );
}

class ScanPhotoSelectorState {
  final AssetEntity photo;

  const ScanPhotoSelectorState(this.photo);

  @override
  bool operator ==(Object other) =>
      other is ScanPhotoSelectorState && photo == other.photo;
}
