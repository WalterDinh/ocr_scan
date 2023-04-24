class SearchHistory {
  int id;
  String textSearch;
  SearchHistory({this.id = -1, this.textSearch = ''});

  Map<String, dynamic> toMap() {
    return {'id': id, 'textSearch': textSearch};
  }

  static SearchHistory fromMap(Map<String, dynamic> map) {
    return SearchHistory(id: map['id'], textSearch: map['textSearch']);
  }
}
