part of 'scan_photo_bloc.dart';

@immutable
abstract class ScanPhotoEvent {
  const ScanPhotoEvent();
}

class ScanPhotoLoadStarted extends ScanPhotoEvent {
  final File? filePhoto;

  const ScanPhotoLoadStarted(this.filePhoto);
}

class ScanTextChanged extends ScanPhotoEvent {
  final String text;

  const ScanTextChanged(this.text);
}
