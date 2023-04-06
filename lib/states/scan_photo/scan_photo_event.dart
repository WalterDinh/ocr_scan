part of 'scan_photo_bloc.dart';

@immutable
abstract class ScanPhotoEvent {
  const ScanPhotoEvent();
}

class ScanPhotoLoadStarted extends ScanPhotoEvent {
  const ScanPhotoLoadStarted();
}

class ScanPhotoLoadMoreStarted extends ScanPhotoEvent {
  const ScanPhotoLoadMoreStarted();
}

class ScanPhotoSelectChanged extends ScanPhotoEvent {
  final AssetEntity photoItem;

  const ScanPhotoSelectChanged({required this.photoItem});
}
