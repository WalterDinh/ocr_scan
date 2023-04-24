part of 'search_bloc.dart';

enum SearchStateStatus {
  initial,
  loading,
  loadDataSearchSuccess,
  loadDataSearchFailure,
  getListRecentSuccess,
  getListRecentFailure
}

class SearchState {
  final List<SearchHistory> listRecent;
  final List<Folder> listFolderDataSearch;
  final List<FileScan> listFileScanDataSearch;

  final SearchStateStatus status;
  final Exception? error;
  const SearchState._({
    this.status = SearchStateStatus.initial,
    this.listRecent = const [],
    this.listFolderDataSearch = const [],
    this.listFileScanDataSearch = const [],
    this.error,
  });
  const SearchState.initial() : this._();

  SearchState asLoading() {
    return copyWith(
      status: SearchStateStatus.loading,
    );
  }

  SearchState asLoadDataSearchSuccess(
      List<FileScan> listFileScan, List<Folder> listFolder) {
    return copyWith(
        status: SearchStateStatus.loadDataSearchSuccess,
        listFileScanDataSearch: listFileScan,
        listFolderDataSearch: listFolder);
  }

  SearchState asLoadListRecentSuccess(List<SearchHistory> listRecent) {
    return copyWith(
      status: SearchStateStatus.getListRecentSuccess,
      listRecent: listRecent,
    );
  }

  SearchState asLoadListRecentFailure(Exception e) {
    return copyWith(
      status: SearchStateStatus.getListRecentFailure,
      error: e,
    );
  }

  SearchState asLoadDataSearchFailure(Exception e) {
    return copyWith(
      status: SearchStateStatus.loadDataSearchFailure,
      error: e,
    );
  }

  SearchState copyWith({
    final List<SearchHistory>? listRecent,
    final List<Folder>? listFolderDataSearch,
    final List<FileScan>? listFileScanDataSearch,
    final SearchStateStatus? status,
    final Exception? error,
  }) {
    return SearchState._(
        status: status ?? this.status,
        listRecent: listRecent ?? this.listRecent,
        listFolderDataSearch: listFolderDataSearch ?? this.listFolderDataSearch,
        listFileScanDataSearch:
            listFileScanDataSearch ?? this.listFileScanDataSearch,
        error: error ?? this.error);
  }
}
