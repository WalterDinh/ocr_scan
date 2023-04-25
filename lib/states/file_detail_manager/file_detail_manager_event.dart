part of 'file_detail_manager_bloc.dart';

@immutable
abstract class FileDetailEvent {
  const FileDetailEvent();
}

class FileDetailLoadStarted extends FileDetailEvent {
  final String dataText;

  const FileDetailLoadStarted(this.dataText);
}

class ScanTextChanged extends FileDetailEvent {
  final String text;
  final FileScan file;
  const ScanTextChanged(this.text, this.file);
}
