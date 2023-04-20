part of 'folder_manager_bloc.dart';

enum FolderManagerStateStatus {
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

class FolderManagerState {
  final List<Folder> listFolder;
  final FolderManagerStateStatus status;
  final Exception? error;
  const FolderManagerState._({
    this.status = FolderManagerStateStatus.initial,
    this.listFolder = const [],
    this.error,
  });
  const FolderManagerState.initial() : this._();

  FolderManagerState asLoading() {
    return copyWith(
      status: FolderManagerStateStatus.loading,
    );
  }

  FolderManagerState asLoadGetAllFolderSuccess(List<Folder> listFolder) {
    return copyWith(
      status: FolderManagerStateStatus.loadSuccess,
      listFolder: listFolder,
    );
  }

  FolderManagerState asLoadCreateFolderSuccess(Folder folder) {
    return copyWith(
      status: FolderManagerStateStatus.createSuccess,
      listFolder: [folder, ...listFolder],
    );
  }

  FolderManagerState asLoadDeleteFolderSuccess(int folderId) {
    return copyWith(
      status: FolderManagerStateStatus.deleteSuccess,
      listFolder:
          [...listFolder].where((element) => element.id != folderId).toList(),
    );
  }

  FolderManagerState asLoadUpdateFolderSuccess(Folder folder) {
    int index = listFolder.indexWhere(((element) => element.id == folder.id));
    listFolder[index] = folder;
    List<Folder> newListFolder = [...listFolder];

    return copyWith(
      status: FolderManagerStateStatus.updateSuccess,
      listFolder: newListFolder,
    );
  }

  FolderManagerState asLoadCreateFolderFailure(Exception e) {
    return copyWith(
      status: FolderManagerStateStatus.createFailure,
      error: e,
    );
  }

  FolderManagerState asLoadGetAllFolderFailure(Exception e) {
    return copyWith(
      status: FolderManagerStateStatus.loadFailure,
      error: e,
    );
  }

  FolderManagerState copyWith({
    final List<Folder>? listFolder,
    final FolderManagerStateStatus? status,
    final Exception? error,
  }) {
    return FolderManagerState._(
        status: status ?? this.status,
        listFolder: listFolder ?? this.listFolder,
        error: error ?? this.error);
  }
}
