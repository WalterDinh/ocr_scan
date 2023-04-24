part of 'folder_detail_bloc.dart';

enum FolderDetailManagerStateStatus {
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

class FolderDetailManagerState {
  final List<FileScan> listFileScan;

  final FolderDetailManagerStateStatus status;
  final Exception? error;
  const FolderDetailManagerState._({
    this.status = FolderDetailManagerStateStatus.initial,
    this.listFileScan = const [],
    this.error,
  });
  const FolderDetailManagerState.initial() : this._();

  FolderDetailManagerState asLoading() {
    return copyWith(
      status: FolderDetailManagerStateStatus.loading,
    );
  }

  FolderDetailManagerState asLoadGetAllFolderDetailSuccess(
      List<FileScan> listFileScan) {
    return copyWith(
      status: FolderDetailManagerStateStatus.loadSuccess,
      listFileScan: listFileScan,
    );
  }

  FolderDetailManagerState asLoadCreateFolderDetailSuccess(FileScan folder) {
    return copyWith(
      status: FolderDetailManagerStateStatus.createSuccess,
      listFileScan: [folder, ...listFileScan],
    );
  }

  FolderDetailManagerState asLoadDeleteFolderDetailSuccess(int folderId) {
    return copyWith(
      status: FolderDetailManagerStateStatus.deleteSuccess,
      listFileScan:
          [...listFileScan].where((element) => element.id != folderId).toList(),
    );
  }

  FolderDetailManagerState asLoadUpdateFolderDetailSuccess(FileScan file) {
    int index = listFileScan.indexWhere(((element) => element.id == file.id));
    listFileScan[index] = file;
    List<FileScan> newListFileScan = [...listFileScan];

    return copyWith(
      status: FolderDetailManagerStateStatus.updateSuccess,
      listFileScan: newListFileScan,
    );
  }

  FolderDetailManagerState asLoadCreateFileScanFailure(Exception e) {
    return copyWith(
      status: FolderDetailManagerStateStatus.createFailure,
      error: e,
    );
  }

  FolderDetailManagerState asLoadGetAllFileScanFailure(Exception e) {
    return copyWith(
      status: FolderDetailManagerStateStatus.loadFailure,
      error: e,
    );
  }

  FolderDetailManagerState copyWith({
    final List<FileScan>? listFileScan,
    final FolderDetailManagerStateStatus? status,
    final Exception? error,
  }) {
    return FolderDetailManagerState._(
        status: status ?? this.status,
        listFileScan: listFileScan ?? this.listFileScan,
        error: error ?? this.error);
  }
}
