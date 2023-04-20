class FileScan {
  int id;
  String title;
  String createDate;
  int size;
  String dataText;
  int folderId;

  FileScan(
      {this.id = -1,
      this.title = '',
      this.createDate = '',
      this.dataText = '',
      this.size = 0,
      this.folderId = -1});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'createDate': createDate,
      'size': size,
      'dataText': dataText,
      'folderId': folderId
    };
  }

  static FileScan fromMap(Map<String, dynamic> map) {
    return FileScan(
      id: map['id'],
      title: map['title'],
      createDate: map['createDate'],
      size: map['size'],
      dataText: map['dataText'],
      folderId: map['folderId'],
    );
  }
}
