import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:stream_transform/stream_transform.dart';

part 'scan_photo_event.dart';
part 'scan_photo_state.dart';

class ScanPhotoBloc extends Bloc<ScanPhotoEvent, ScanPhotoState> {
  static const int photoPerPage = 20;

  ScanPhotoBloc() : super(const ScanPhotoState.initial()) {
    on<ScanPhotoLoadStarted>(_onLoadStarted,
        transformer: (events, mapper) => events.switchMap(mapper));
    on<ScanPhotoLoadMoreStarted>(
      _onLoadMoreStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<ScanPhotoSelectChanged>(_onSelectChanged);
  }

  void _onLoadStarted(
      ScanPhotoLoadStarted event, Emitter<ScanPhotoState> emit) async {
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

  void _onLoadMoreStarted(
      ScanPhotoLoadMoreStarted event, Emitter<ScanPhotoState> emit) async {
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

  void _onSelectChanged(
      ScanPhotoSelectChanged event, Emitter<ScanPhotoState> emit) {
    emit(state.copyWith(
      selectedPhoto: event.photoItem,
    ));
  }
}
