part of 'scan_photo_bloc.dart';

enum ScanPhotoStateStatus { initial, loading, loadSuccess, loadFailure }

class ScanPhotoState {
  final ScanPhotoStateStatus status;
  final List<String> dataText;
  final AssetEntity? selectedPhoto;
  final Exception? error;

  const ScanPhotoState._({
    this.status = ScanPhotoStateStatus.initial,
    this.dataText = const [],
    this.selectedPhoto,
    this.error,
  });
  const ScanPhotoState.initial() : this._();

  ScanPhotoState asLoading() {
    return copyWith(
      status: ScanPhotoStateStatus.loading,
    );
  }

  ScanPhotoState asLoadSuccess(List<String> dataText) {
    return copyWith(
      status: ScanPhotoStateStatus.loadSuccess,
      dataText: dataText,
    );
  }

  ScanPhotoState asLoadFailure(Exception e) {
    return copyWith(
      status: ScanPhotoStateStatus.loadFailure,
      error: e,
    );
  }

  ScanPhotoState copyWith({
    ScanPhotoStateStatus? status,
    List<String>? dataText,
    final AssetEntity? selectedPhoto,
    Exception? error,
  }) {
    return ScanPhotoState._(
      status: status ?? this.status,
      dataText: dataText ?? this.dataText,
      selectedPhoto: selectedPhoto ?? this.selectedPhoto,
      error: error ?? this.error,
    );
  }
}
