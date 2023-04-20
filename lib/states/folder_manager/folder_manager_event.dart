part of 'folder_manager_bloc.dart';

@immutable
abstract class FolderManagerEvent {
  const FolderManagerEvent();
}

class GetAllFolderStarted extends FolderManagerEvent {
  const GetAllFolderStarted();
}

class DeleteFolderStarted extends FolderManagerEvent {
  final int folderId;
  const DeleteFolderStarted(this.folderId);
}

class CreateFolderStarted extends FolderManagerEvent {
  final Folder folder;
  const CreateFolderStarted(this.folder);
}

class UpdateFolderStarted extends FolderManagerEvent {
  final Folder folder;
  const UpdateFolderStarted(this.folder);
}
