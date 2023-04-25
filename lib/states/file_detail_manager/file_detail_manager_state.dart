part of 'file_detail_manager_bloc.dart';

enum FileDetailStateStatus { initial, loading, loadSuccess, loadFailure }

class FileDetailState {
  final FileDetailStateStatus status;
  final String dataText;
  final AssetEntity? selectedPhoto;
  final Exception? error;
  final File? pdfFile;
  const FileDetailState._({
    this.pdfFile,
    this.status = FileDetailStateStatus.initial,
    this.dataText = '',
    this.selectedPhoto,
    this.error,
  });
  const FileDetailState.initial() : this._();

  FileDetailState asLoading() {
    return copyWith(
      status: FileDetailStateStatus.loading,
    );
  }

  FileDetailState asLoadSuccess(String dataText, File file) {
    return copyWith(
      status: FileDetailStateStatus.loadSuccess,
      pdfFile: file,
      dataText: dataText,
    );
  }

  FileDetailState asLoadFailure(Exception e) {
    return copyWith(
      status: FileDetailStateStatus.loadFailure,
      error: e,
    );
  }

  FileDetailState copyWith({
    File? pdfFile,
    FileDetailStateStatus? status,
    String? dataText,
    final AssetEntity? selectedPhoto,
    Exception? error,
  }) {
    return FileDetailState._(
      pdfFile: pdfFile ?? this.pdfFile,
      status: status ?? this.status,
      dataText: dataText ?? this.dataText,
      selectedPhoto: selectedPhoto ?? this.selectedPhoto,
      error: error ?? this.error,
    );
  }
}
