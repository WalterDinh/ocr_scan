part of 'select_image_from_gallery_bloc.dart';

enum SelectImageFromGalleryStateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure,
  loadingMore,
  loadMoreSuccess,
  loadMoreFailure,
}

class SelectImageFromGalleryState {
  final SelectImageFromGalleryStateStatus status;
  final List<AssetEntity> mediaList;
  final AssetEntity? selectedPhoto;
  final int? selectedIndex;
  final int page;
  final Exception? error;
  final bool canLoadMore;

  const SelectImageFromGalleryState._(
      {this.status = SelectImageFromGalleryStateStatus.initial,
      this.mediaList = const [],
      this.selectedPhoto,
      this.selectedIndex,
      this.page = 0,
      this.error,
      this.canLoadMore = true});
  const SelectImageFromGalleryState.initial() : this._();

  SelectImageFromGalleryState asLoading() {
    return copyWith(
      status: SelectImageFromGalleryStateStatus.loading,
    );
  }

  SelectImageFromGalleryState asLoadSuccess(List<AssetEntity> mediaList,
      {bool canLoadMore = true}) {
    return copyWith(
      status: SelectImageFromGalleryStateStatus.loadSuccess,
      mediaList: mediaList,
      page: 1,
      canLoadMore: canLoadMore,
    );
  }

  SelectImageFromGalleryState asLoadFailure(Exception e) {
    return copyWith(
      status: SelectImageFromGalleryStateStatus.loadFailure,
      error: e,
    );
  }

  SelectImageFromGalleryState asLoadingMore() {
    return copyWith(status: SelectImageFromGalleryStateStatus.loadingMore);
  }

  SelectImageFromGalleryState asLoadMoreSuccess(List<AssetEntity> newMediaList,
      {bool canLoadMore = true}) {
    return copyWith(
      status: SelectImageFromGalleryStateStatus.loadMoreSuccess,
      mediaList: [...mediaList, ...newMediaList],
      page: canLoadMore ? page + 1 : page,
      canLoadMore: canLoadMore,
    );
  }

  SelectImageFromGalleryState asLoadMoreFailure(Exception e) {
    return copyWith(
      status: SelectImageFromGalleryStateStatus.loadMoreFailure,
      error: e,
    );
  }

  SelectImageFromGalleryState copyWith({
    SelectImageFromGalleryStateStatus? status,
    List<AssetEntity>? mediaList,
    final AssetEntity? selectedPhoto,
    final int? selectedIndex,
    int? page,
    bool? canLoadMore,
    Exception? error,
  }) {
    return SelectImageFromGalleryState._(
      status: status ?? this.status,
      mediaList: mediaList ?? this.mediaList,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedPhoto: selectedPhoto ?? this.selectedPhoto,
      page: page ?? this.page,
      canLoadMore: canLoadMore ?? this.canLoadMore,
      error: error ?? this.error,
    );
  }
}
