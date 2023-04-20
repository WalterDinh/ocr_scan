class Folder {
  int id;
  String title;
  int totalFile;
  Folder({this.id = -1, this.title = '', this.totalFile = 0});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'totalFile': totalFile};
  }

  static Folder fromMap(Map<String, dynamic> map) {
    return Folder(
        id: map['id'], title: map['title'], totalFile: map['totalFile']);
  }
}
