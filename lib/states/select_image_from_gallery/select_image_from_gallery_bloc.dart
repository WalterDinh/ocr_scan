import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:stream_transform/stream_transform.dart';

part 'select_image_from_gallery_event.dart';
part 'select_image_from_gallery_state.dart';

class SelectImageFromGalleryBloc
    extends Bloc<SelectImageFromGalleryEvent, SelectImageFromGalleryState> {
  static const int photoPerPage = 20;

  SelectImageFromGalleryBloc()
      : super(const SelectImageFromGalleryState.initial()) {
    on<SelectImageFromGalleryLoadStarted>(_onLoadStarted,
        transformer: (events, mapper) => events.switchMap(mapper));
    on<SelectImageFromGalleryLoadMoreStarted>(
      _onLoadMoreStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<SelectImageFromGallerySelectChanged>(_onSelectChanged);
  }

  void _onLoadStarted(SelectImageFromGalleryLoadStarted event,
      Emitter<SelectImageFromGalleryState> emit) async {
    try {
      emit(state.asLoading());
      PermissionState result = await PhotoManager.requestPermissionExtend();
      if (result.isAuth) {
        List<AssetPathEntity> albums =
            await PhotoManager.getAssetPathList(onlyAll: true);
        List<AssetEntity> media = await albums[0]
            .getAssetListPaged(page: state.page, size: photoPerPage);
        bool canLoadMore = media.length == photoPerPage;
        emit(state.asLoadSuccess(media, canLoadMore: canLoadMore));
      } else {
        PhotoManager.openSetting();
      }
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  void _onLoadMoreStarted(SelectImageFromGalleryLoadMoreStarted event,
      Emitter<SelectImageFromGalleryState> emit) async {
    try {
      if (!state.canLoadMore) return;

      emit(state.asLoadingMore());
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);
      List<AssetEntity> media = await albums[0]
          .getAssetListPaged(page: state.page, size: photoPerPage);
      bool canLoadMore = media.length == photoPerPage;
      emit(state.asLoadMoreSuccess(media, canLoadMore: canLoadMore));
    } on Exception catch (e) {
      emit(state.asLoadMoreFailure(e));
    }
  }

  void _onSelectChanged(SelectImageFromGallerySelectChanged event,
      Emitter<SelectImageFromGalleryState> emit) {
    emit(state.copyWith(
      selectedPhoto: state.mediaList[event.photoIndex],
      selectedIndex: event.photoIndex,
    ));
  }
}
