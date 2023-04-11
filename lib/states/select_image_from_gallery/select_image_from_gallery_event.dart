part of 'select_image_from_gallery_bloc.dart';

@immutable
abstract class SelectImageFromGalleryEvent {
  const SelectImageFromGalleryEvent();
}

class SelectImageFromGalleryLoadStarted extends SelectImageFromGalleryEvent {
  const SelectImageFromGalleryLoadStarted();
}

class SelectImageFromGalleryLoadMoreStarted
    extends SelectImageFromGalleryEvent {}

class SelectImageFromGallerySelectChanged extends SelectImageFromGalleryEvent {
  final int photoIndex;

  const SelectImageFromGallerySelectChanged({required this.photoIndex});
}

class SelectImageFromGallerySetPhoto extends SelectImageFromGalleryEvent {
  final File file;

  const SelectImageFromGallerySetPhoto({required this.file});
}
