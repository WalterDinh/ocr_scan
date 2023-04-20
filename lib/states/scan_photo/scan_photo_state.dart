part of 'scan_photo_bloc.dart';

enum ScanPhotoStateStatus { initial, loading, loadSuccess, loadFailure }

class ScanPhotoState {
  final ScanPhotoStateStatus status;
  final String dataText;
  final AssetEntity? selectedPhoto;
  final Exception? error;
  final File? pdfFile;
  const ScanPhotoState._({
    this.pdfFile,
    this.status = ScanPhotoStateStatus.initial,
    this.dataText = '',
    this.selectedPhoto,
    this.error,
  });
  const ScanPhotoState.initial() : this._();

  ScanPhotoState asLoading() {
    return copyWith(
      status: ScanPhotoStateStatus.loading,
    );
  }

  ScanPhotoState asLoadSuccess(String dataText, File file) {
    return copyWith(
      status: ScanPhotoStateStatus.loadSuccess,
      pdfFile: file,
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
    File? pdfFile,
    ScanPhotoStateStatus? status,
    String? dataText,
    final AssetEntity? selectedPhoto,
    Exception? error,
  }) {
    return ScanPhotoState._(
      pdfFile: pdfFile ?? this.pdfFile,
      status: status ?? this.status,
      dataText: dataText ?? this.dataText,
      selectedPhoto: selectedPhoto ?? this.selectedPhoto,
      error: error ?? this.error,
    );
  }
}
