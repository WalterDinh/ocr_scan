import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app/data/repositories/local_repository.dart';
import 'package:my_app/data/source/local/model/file_scan.dart';
import 'package:my_app/data/source/local/model/folder.dart';
import 'package:my_app/data/source/local/model/search_history.dart';

import 'package:stream_transform/stream_transform.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final LocalDataRepository _localDataRepository;

  SearchBloc(this._localDataRepository) : super(const SearchState.initial()) {
    on<SearchFileAndFolderStarted>(_onSearchFileAndFolder,
        transformer: (events, mapper) => events.switchMap(mapper));

    on<GetRecentSearchStarted>(_onGetRecentSearch,
        transformer: (events, mapper) => events.switchMap(mapper));
  }

  void _onSearchFileAndFolder(
      SearchFileAndFolderStarted event, Emitter<SearchState> emit) async {
    try {
      emit(state.asLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      List<Folder> listFolder =
          await _localDataRepository.getDataSearchFolder(event.textSearch);
      List<FileScan> listFile =
          await _localDataRepository.getDataSearchFileScan(event.textSearch);

      emit(state.asLoadDataSearchSuccess(listFile, listFolder));
      if (event.textSearch.isNotEmpty) {
        await _localDataRepository.insertSearchHistory(
            dataSearch: SearchHistory(textSearch: event.textSearch));
        List<SearchHistory> listHistory =
            await _localDataRepository.getAllSearchHistory();
        emit(state.asLoadListRecentSuccess(listHistory));
      }
    } on Exception catch (e) {
      emit(state.asLoadDataSearchFailure(e));
    }
  }

  void _onGetRecentSearch(
      GetRecentSearchStarted event, Emitter<SearchState> emit) async {
    try {
      List<SearchHistory> dataRecent =
          await _localDataRepository.getAllSearchHistory();
      emit(state.asLoadListRecentSuccess(dataRecent));
    } on Exception catch (e) {
      emit(state.asLoadListRecentFailure(e));
    }
  }
}
