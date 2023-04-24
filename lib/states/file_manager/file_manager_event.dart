part of 'file_manager_bloc.dart';

@immutable
abstract class FileScanManagerEvent {
  const FileScanManagerEvent();
}

class GetAllFileScanStarted extends FileScanManagerEvent {
  const GetAllFileScanStarted();
}

class DeleteFileScanStarted extends FileScanManagerEvent {
  final FileScan file;
  const DeleteFileScanStarted(this.file);
}

class CreateFileScanStarted extends FileScanManagerEvent {
  final FileScan fileScan;
  const CreateFileScanStarted(this.fileScan);
}

class UpdateFileScanStarted extends FileScanManagerEvent {
  final FileScan fileScan;
  final Folder? folder;

  const UpdateFileScanStarted(this.fileScan, this.folder);
}
