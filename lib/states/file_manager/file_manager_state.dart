part of 'file_manager_bloc.dart';

enum FileScanManagerStateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure,
  createSuccess,
  createFailure,
  deleteSuccess,
  deleteFailure,
  updateSuccess,
  updateFailure
}

class FileScanManagerState {
  final List<FileScan> listFileScan;
  final FileScanManagerStateStatus status;
  final Exception? error;
  const FileScanManagerState._({
    this.status = FileScanManagerStateStatus.initial,
    this.listFileScan = const [],
    this.error,
  });
  const FileScanManagerState.initial() : this._();

  FileScanManagerState asLoading() {
    return copyWith(
      status: FileScanManagerStateStatus.loading,
    );
  }

  FileScanManagerState asLoadGetAllFileScanSuccess(
      List<FileScan> listFileScan) {
    return copyWith(
      status: FileScanManagerStateStatus.loadSuccess,
      listFileScan: listFileScan,
    );
  }

  FileScanManagerState asLoadCreateFileScanSuccess(FileScan folder) {
    return copyWith(
      status: FileScanManagerStateStatus.createSuccess,
      listFileScan: [folder, ...listFileScan],
    );
  }

  FileScanManagerState asLoadDeleteFileScanSuccess(int folderId) {
    return copyWith(
      status: FileScanManagerStateStatus.deleteSuccess,
      listFileScan:
          [...listFileScan].where((element) => element.id != folderId).toList(),
    );
  }

  FileScanManagerState asLoadUpdateFileScanSuccess(FileScan file) {
    int index = listFileScan.indexWhere(((element) => element.id == file.id));
    listFileScan[index] = file;
    List<FileScan> newListFileScan = [...listFileScan];

    return copyWith(
      status: FileScanManagerStateStatus.updateSuccess,
      listFileScan: newListFileScan,
    );
  }

  FileScanManagerState asLoadCreateFileScanFailure(Exception e) {
    return copyWith(
      status: FileScanManagerStateStatus.createFailure,
      error: e,
    );
  }

  FileScanManagerState asLoadGetAllFileScanFailure(Exception e) {
    return copyWith(
      status: FileScanManagerStateStatus.loadFailure,
      error: e,
    );
  }

  FileScanManagerState copyWith({
    final List<FileScan>? listFileScan,
    final FileScanManagerStateStatus? status,
    final Exception? error,
  }) {
    return FileScanManagerState._(
        status: status ?? this.status,
        listFileScan: listFileScan ?? this.listFileScan,
        error: error ?? this.error);
  }
}
