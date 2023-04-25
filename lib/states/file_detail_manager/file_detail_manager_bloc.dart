import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app/core/pdf.dart';
import 'package:my_app/data/source/local/model/file_scan.dart';

import 'package:my_app/states/file_manager/file_manager_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:stream_transform/stream_transform.dart';

part 'file_detail_manager_event.dart';
part 'file_detail_manager_state.dart';

class FileDetailBloc extends Bloc<FileDetailEvent, FileDetailState> {
  final FileScanManagerBloc _fileScanManagerBloc;

  FileDetailBloc(this._fileScanManagerBloc)
      : super(const FileDetailState.initial()) {
    on<FileDetailLoadStarted>(_onLoadStarted,
        transformer: (events, mapper) => events.switchMap(mapper));
    on<ScanTextChanged>(_onTextChanged);
  }

  void _onLoadStarted(
      FileDetailLoadStarted event, Emitter<FileDetailState> emit) async {
    try {
      emit(state.asLoading());
      final pdf = await PdfApi.generateCenteredText(event.dataText);
      emit(state.asLoadSuccess(event.dataText, pdf));
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  Future<void> _onTextChanged(
      ScanTextChanged event, Emitter<FileDetailState> emit) async {
    final dataText = event.text;
    final pdf = await PdfApi.generateCenteredText(dataText);
    event.file.dataText = event.text;
    _fileScanManagerBloc.add(UpdateFileScanStarted(event.file, null));
    emit(state.copyWith(dataText: event.text, pdfFile: pdf));
  }
}
