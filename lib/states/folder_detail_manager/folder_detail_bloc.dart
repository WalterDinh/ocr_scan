import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app/data/repositories/local_repository.dart';
import 'package:my_app/data/source/local/model/file_scan.dart';
import 'package:my_app/data/source/local/model/folder.dart';

import 'package:stream_transform/stream_transform.dart';

part 'folder_detail_event.dart';
part 'folder_detail_state.dart';

class FolderDetailBloc
    extends Bloc<FolderDetailManagerEvent, FolderDetailManagerState> {
  final LocalDataRepository _localDataRepository;

  FolderDetailBloc(this._localDataRepository)
      : super(const FolderDetailManagerState.initial()) {
    on<CreateFileFolderDetailStarted>(_onCreateFileScan,
        transformer: (events, mapper) => events.switchMap(mapper));

    on<DeleteFileFolderDetailStarted>(_onDeleteFileScan,
        transformer: (events, mapper) => events.switchMap(mapper));
    on<UpdateFileFolderDetailStarted>(_onUpdateFileScan,
        transformer: (events, mapper) => events.switchMap(mapper));
    on<GetAllFileScanByFolderStarted>(_onGetFileScanByFolder,
        transformer: (events, mapper) => events.switchMap(mapper));
  }

  void _onCreateFileScan(CreateFileFolderDetailStarted event,
      Emitter<FolderDetailManagerState> emit) async {
    try {
      int folderId =
          await _localDataRepository.insertFile(file: event.fileScan);
      if (folderId >= 0) {
        emit(state.asLoadCreateFolderDetailSuccess(event.fileScan));
      }
      emit(state.asLoadGetAllFileScanFailure(Exception()));
    } on Exception catch (e) {
      emit(state.asLoadGetAllFileScanFailure(e));
    }
  }

  void _onDeleteFileScan(DeleteFileFolderDetailStarted event,
      Emitter<FolderDetailManagerState> emit) async {
    try {
      await _localDataRepository.deleteFile(file: event.file);
      emit(state.asLoadDeleteFolderDetailSuccess(event.file.id));
    } on Exception {
      emit(
          state.copyWith(status: FolderDetailManagerStateStatus.deleteFailure));
    }
  }

  void _onUpdateFileScan(UpdateFileFolderDetailStarted event,
      Emitter<FolderDetailManagerState> emit) async {
    try {
      await _localDataRepository.updateFile(
          file: event.fileScan, folder: event.folder);
      emit(state.asLoadUpdateFolderDetailSuccess(event.fileScan));
    } on Exception {
      emit(
          state.copyWith(status: FolderDetailManagerStateStatus.updateFailure));
    }
  }

  void _onGetFileScanByFolder(GetAllFileScanByFolderStarted event,
      Emitter<FolderDetailManagerState> emit) async {
    try {
      List<FileScan> folderList = await _localDataRepository
          .getFileScanByFolder(folderId: event.folderId);
      emit(state.asLoadGetAllFolderDetailSuccess(folderList));
    } on Exception {
      emit(
          state.copyWith(status: FolderDetailManagerStateStatus.updateFailure));
    }
  }
}
