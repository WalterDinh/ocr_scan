part of 'scan_photo_bloc.dart';

enum ScanPhotoStateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure,
  loadingMore,
  loadMoreSuccess,
  loadMoreFailure,
}

class ScanPhotoState {
  final ScanPhotoStateStatus status;
  final List<AssetEntity> mediaList;
  final AssetEntity? selectedPhoto;
  final int page;
  final Exception? error;
  final bool canLoadMore;

  const ScanPhotoState._(
      {this.status = ScanPhotoStateStatus.initial,
      this.mediaList = const [],
      this.selectedPhoto,
      this.page = 0,
      this.error,
      this.canLoadMore = true});
  const ScanPhotoState.initial() : this._();

  ScanPhotoState asLoading() {
    return copyWith(
      status: ScanPhotoStateStatus.loading,
    );
  }

  ScanPhotoState asLoadSuccess(List<AssetEntity> mediaList,
      {bool canLoadMore = true}) {
    return copyWith(
      status: ScanPhotoStateStatus.loadSuccess,
      mediaList: mediaList,
      page: 1,
      canLoadMore: canLoadMore,
    );
  }

  ScanPhotoState asLoadFailure(Exception e) {
    return copyWith(
      status: ScanPhotoStateStatus.loadFailure,
      error: e,
    );
  }

  ScanPhotoState asLoadingMore() {
    return copyWith(status: ScanPhotoStateStatus.loadingMore);
  }

  ScanPhotoState asLoadMoreSuccess(List<AssetEntity> newMediaList,
      {bool canLoadMore = true}) {
    return copyWith(
      status: ScanPhotoStateStatus.loadMoreSuccess,
      mediaList: [...mediaList, ...newMediaList],
      page: canLoadMore ? page + 1 : page,
      canLoadMore: canLoadMore,
    );
  }

  ScanPhotoState asLoadMoreFailure(Exception e) {
    return copyWith(
      status: ScanPhotoStateStatus.loadMoreFailure,
      error: e,
    );
  }

  ScanPhotoState copyWith({
    ScanPhotoStateStatus? status,
    List<AssetEntity>? mediaList,
    final AssetEntity? selectedPhoto,
    int? page,
    bool? canLoadMore,
    Exception? error,
  }) {
    return ScanPhotoState._(
      status: status ?? this.status,
      mediaList: mediaList ?? this.mediaList,
      selectedPhoto: selectedPhoto ?? this.selectedPhoto,
      page: page ?? this.page,
      canLoadMore: canLoadMore ?? this.canLoadMore,
      error: error ?? this.error,
    );
  }
}
