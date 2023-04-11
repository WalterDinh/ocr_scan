import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/states/select_image_from_gallery/select_image_from_gallery_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

class SelectImageFromGalleryStateSelector<T> extends BlocSelector<
    SelectImageFromGalleryBloc, SelectImageFromGalleryState, T> {
  SelectImageFromGalleryStateSelector({
    required T Function(SelectImageFromGalleryState) selector,
    required Widget Function(T) builder,
  }) : super(
          selector: selector,
          builder: (_, value) => builder(value),
        );
}

class SelectImageFromGalleryStateStatusSelector
    extends SelectImageFromGalleryStateSelector<
        SelectImageFromGalleryStateStatus> {
  SelectImageFromGalleryStateStatusSelector(
      Widget Function(SelectImageFromGalleryStateStatus) builder)
      : super(
          selector: (state) => state.status,
          builder: builder,
        );
}

class PhotoImageCanLoadMoreSelector
    extends SelectImageFromGalleryStateSelector<bool> {
  PhotoImageCanLoadMoreSelector(Widget Function(bool) builder)
      : super(
          selector: (state) => state.canLoadMore,
          builder: builder,
        );
}

class PhotoImagesSelector
    extends SelectImageFromGalleryStateSelector<List<AssetEntity>> {
  PhotoImagesSelector(Widget Function(List<AssetEntity>) builder)
      : super(
          selector: (state) => state.mediaList,
          builder: builder,
        );
}

class CurrentSelectedImageSelector
    extends SelectImageFromGalleryStateSelector<AssetEntity?> {
  CurrentSelectedImageSelector(Widget Function(AssetEntity?) builder)
      : super(
          selector: (state) => state.selectedPhoto,
          builder: builder,
        );
}

class SelectImageFromGallerySelector
    extends SelectImageFromGalleryStateSelector<
        SelectImageFromGallerySelectorState> {
  SelectImageFromGallerySelector(
      int index, Widget Function(AssetEntity, bool) builder)
      : super(
          selector: (state) => SelectImageFromGallerySelectorState(
            state.mediaList[index],
            state.selectedIndex == index,
          ),
          builder: (value) => builder(value.image, value.selected),
        );
}

class SelectImageFromGallerySelectorState {
  final AssetEntity image;
  final bool selected;

  const SelectImageFromGallerySelectorState(this.image, this.selected);

  @override
  bool operator ==(Object other) =>
      other is SelectImageFromGallerySelectorState &&
      image == other.image &&
      selected == other.selected;
}
