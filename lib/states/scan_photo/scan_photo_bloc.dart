import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app/data/repositories/scan_repository.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:stream_transform/stream_transform.dart';

part 'scan_photo_event.dart';
part 'scan_photo_state.dart';

class ScanPhotoBloc extends Bloc<ScanPhotoEvent, ScanPhotoState> {
  final ScanPhotoRepository _scanRepository;

  ScanPhotoBloc(this._scanRepository) : super(const ScanPhotoState.initial()) {
    on<ScanPhotoLoadStarted>(_onLoadStarted,
        transformer: (events, mapper) => events.switchMap(mapper));
  }

  void _onLoadStarted(
      ScanPhotoLoadStarted event, Emitter<ScanPhotoState> emit) async {
    try {
      emit(state.asLoading());
      if (event.filePhoto != null) {
        print(event.filePhoto);

        final dataText =
            await _scanRepository.getTextFromImage(event.filePhoto);
        print(dataText);

        emit(state.asLoadSuccess(dataText));
      } else {
        emit(state.asLoadFailure(Exception()));
      }
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }
}
