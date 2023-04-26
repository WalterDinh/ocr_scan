import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app/data/repositories/local_repository.dart';
import 'package:my_app/data/source/local/model/file_scan.dart';
import 'package:my_app/data/source/local/model/folder.dart';

import 'package:stream_transform/stream_transform.dart';

part 'file_manager_event.dart';
part 'file_manager_state.dart';

class FileScanManagerBloc
    extends Bloc<FileScanManagerEvent, FileScanManagerState> {
  final LocalDataRepository _localDataRepository;

  FileScanManagerBloc(this._localDataRepository)
      : super(const FileScanManagerState.initial()) {
    on<GetAllFileScanStarted>(_onGetAllFileScans,
        transformer: (events, mapper) => events.switchMap(mapper));
    on<CreateFileScanStarted>(_onCreateFileScan,
        transformer: (events, mapper) => events.switchMap(mapper));

    on<DeleteFileScanStarted>(_onDeleteFileScan,
        transformer: (events, mapper) => events.switchMap(mapper));
    on<UpdateFileScanStarted>(_onUpdateFileScan,
        transformer: (events, mapper) => events.switchMap(mapper));
  }

  void _onGetAllFileScans(
      GetAllFileScanStarted event, Emitter<FileScanManagerState> emit) async {
    try {
      emit(state.asLoading());

      List<FileScan> folderList = await _localDataRepository.getAllFile();

      emit(state.asLoadGetAllFileScanSuccess(folderList));
    } on Exception catch (e) {
      emit(state.asLoadGetAllFileScanFailure(e));
    }
  }

  void _onCreateFileScan(
      CreateFileScanStarted event, Emitter<FileScanManagerState> emit) async {
    try {
      int folderId =
          await _localDataRepository.insertFile(file: event.fileScan);
      if (folderId >= 0) {
        emit(state.asLoadCreateFileScanSuccess(event.fileScan));
      }
      emit(state.asLoadGetAllFileScanFailure(Exception()));
    } on Exception catch (e) {
      emit(state.asLoadGetAllFileScanFailure(e));
    }
  }

  void _onDeleteFileScan(
      DeleteFileScanStarted event, Emitter<FileScanManagerState> emit) async {
    try {
      await _localDataRepository.deleteFile(file: event.file);
      emit(state.asLoadDeleteFileScanSuccess(event.file.id));
    } on Exception {
      emit(state.copyWith(status: FileScanManagerStateStatus.deleteFailure));
    }
  }

  void _onUpdateFileScan(
      UpdateFileScanStarted event, Emitter<FileScanManagerState> emit) async {
    try {
      await _localDataRepository.updateFile(
          file: event.fileScan, folder: event.folder);
      FileScan newFile = event.fileScan;
      newFile.folderId = event.folder!.id;
      await _localDataRepository.getAllFolder();
      emit(state.asLoadUpdateFileScanSuccess(newFile));
    } on Exception {
      emit(state.copyWith(status: FileScanManagerStateStatus.updateFailure));
    }
  }
}
