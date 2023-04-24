import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:my_app/core/pdf.dart';
import 'package:my_app/data/repositories/scan_repository.dart';
import 'package:my_app/data/source/local/model/file_scan.dart';
import 'package:my_app/states/file_manager/file_manager_bloc.dart';
import 'package:my_app/utils/size.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:stream_transform/stream_transform.dart';

part 'scan_photo_event.dart';
part 'scan_photo_state.dart';

class ScanPhotoBloc extends Bloc<ScanPhotoEvent, ScanPhotoState> {
  final ScanPhotoRepository _scanRepository;
  final FileScanManagerBloc _fileScanManagerBloc;

  ScanPhotoBloc(this._scanRepository, this._fileScanManagerBloc)
      : super(const ScanPhotoState.initial()) {
    on<ScanPhotoLoadStarted>(_onLoadStarted,
        transformer: (events, mapper) => events.switchMap(mapper));
    on<ScanTextChanged>(_onTextChanged);
  }

  void _onLoadStarted(
      ScanPhotoLoadStarted event, Emitter<ScanPhotoState> emit) async {
    try {
      emit(state.asLoading());
      if (event.filePhoto != null) {
        final dataText =
            await _scanRepository.getTextFromImage(event.filePhoto);

        if (dataText.isNotEmpty) {
          String text = dataText.reduce((value, element) => '$value\n$element');
          final pdf = await PdfApi.generateCenteredText(text);
          DateTime now = DateTime.now();
          String formattedDate = DateFormat('MM/dd/yyyy').format(now);
          String fileSize = await getFileSize(pdf.path, 0);
          _fileScanManagerBloc.add(CreateFileScanStarted(FileScan(
              createDate: formattedDate,
              dataText: text,
              title: 'Scan documents',
              size: fileSize)));

          emit(state.asLoadSuccess(text, pdf));
        } else {
          emit(state.asLoadFailure(Exception()));
        }
      } else {
        emit(state.asLoadFailure(Exception()));
      }
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  Future<void> _onTextChanged(
      ScanTextChanged event, Emitter<ScanPhotoState> emit) async {
    final dataText = event.text;
    final pdf = await PdfApi.generateCenteredText(dataText);
    emit(state.copyWith(dataText: event.text, pdfFile: pdf));
  }
}
