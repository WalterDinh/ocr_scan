part of 'folder_detail_bloc.dart';

@immutable
abstract class FolderDetailManagerEvent {
  const FolderDetailManagerEvent();
}

class GetAllFileScanByFolderStarted extends FolderDetailManagerEvent {
  final int folderId;

  const GetAllFileScanByFolderStarted(this.folderId);
}

class DeleteFileFolderDetailStarted extends FolderDetailManagerEvent {
  final FileScan file;
  const DeleteFileFolderDetailStarted(this.file);
}

class CreateFileFolderDetailStarted extends FolderDetailManagerEvent {
  final FileScan fileScan;
  const CreateFileFolderDetailStarted(this.fileScan);
}

class UpdateFileFolderDetailStarted extends FolderDetailManagerEvent {
  final FileScan fileScan;
  final Folder? folder;

  const UpdateFileFolderDetailStarted(this.fileScan, this.folder);
}
