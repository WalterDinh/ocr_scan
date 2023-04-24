part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {
  const SearchEvent();
}

class DeleteSearchHistoryStarted extends SearchEvent {
  final int id;
  const DeleteSearchHistoryStarted(this.id);
}

class SearchFileAndFolderStarted extends SearchEvent {
  final String textSearch;
  const SearchFileAndFolderStarted(this.textSearch);
}

class GetRecentSearchStarted extends SearchEvent {
  const GetRecentSearchStarted();
}
