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

class CurrentScanDataTextSelector extends ScanPhotoStateSelector<List<String>> {
  CurrentScanDataTextSelector(Widget Function(List<String>) builder)
      : super(
          selector: (state) => state.dataText,
          builder: builder,
        );
}

class ScanPhotoSelectorState {
  final AssetEntity photo;

  const ScanPhotoSelectorState(this.photo);

  @override
  bool operator ==(Object other) =>
      other is ScanPhotoSelectorState && photo == other.photo;
}
