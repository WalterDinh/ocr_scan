import 'package:my_app/data/source/local/model/file_scan.dart';
import 'package:my_app/data/source/local/model/folder.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSource {
  static final LocalDataSource db = LocalDataSource();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();

    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'folders.db'),
      onCreate: _createDatabase,
      version: 1,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE folders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        totalFile INTEGER,
        title TEXT
      )
      ''');

    await db.execute('''
      CREATE TABLE file_scan (
        id INTEGER PRIMARY KEY,
        title TEXT,
        createDate TEXT,
        size INTEGER,
        dataText TEXT,
        folderId INTEGER,
        FOREIGN KEY (folderId) REFERENCES folders (id)
          ON DELETE CASCADE
          ON UPDATE CASCADE
      )
      ''');
  }

  Future<int> insertFolder(Folder folder) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db!.rawQuery("SELECT MAX(id)+1 as id FROM folders");
    int? id = table.first['id'] as int?;

    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into folders (id,totalFile,title)"
        " VALUES (?,?,?)",
        [id, folder.totalFile, folder.title]);

    return raw;
  }

  Future<List<Folder>> getAllFolders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('folders');
    List<Folder> list =
        maps.isNotEmpty ? maps.map((c) => Folder.fromMap(c)).toList() : [];

    return list;
  }

  Future<List<FileScan>> getListFileScanByFolder(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db!.query('file_scan', where: 'folderId = ?', whereArgs: [id]);
    List<FileScan> list =
        maps.isNotEmpty ? maps.map((c) => FileScan.fromMap(c)).toList() : [];

    return list;
  }

  Future<int> insertFileScan(FileScan fileScan) async {
    final db = await database;
    var table = await db!.rawQuery("SELECT MAX(id)+1 as id FROM file_scan");
    int? id = table.first['id'] as int?;

    var raw = await db.rawInsert(
        "INSERT Into file_scan (id,title,createDate,dataText,folderId,size)"
        " VALUES (?,?,?,?,?,?)",
        [
          id,
          fileScan.title,
          fileScan.createDate,
          fileScan.dataText,
          fileScan.folderId,
          fileScan.size
        ]);

    return raw;
  }

  Future<Folder> getFolder(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db!.query('folders', where: 'id = ?', whereArgs: [id]);
    List<Folder> list =
        maps.isNotEmpty ? maps.map((c) => Folder.fromMap(c)).toList() : [];

    return list.first;
  }

  Future<void> updateFile(FileScan file, Folder? folder) async {
    final db = await database;
    await db!.update(
      'file_scan',
      file.toMap(),
      where: 'id = ?',
      whereArgs: [file.id],
    );
    if (folder != null) {
      await db.update(
        'folders',
        folder.toMap(),
        where: 'id = ?',
        whereArgs: [folder.id],
      );
    }
  }

  Future<void> deleteFile(int id, Folder? folder) async {
    final db = await database;
    await db!.delete(
      'file_scan',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (folder != null) {
      await db.update(
        'folders',
        folder.toMap(),
        where: 'id = ?',
        whereArgs: [folder.id],
      );
    }
  }

  Future<void> updateFolder(Folder folder) async {
    final db = await database;
    await db!.update(
      'folders',
      folder.toMap(),
      where: 'id = ?',
      whereArgs: [folder.id],
    );
  }

  Future<void> deleteFolder(int id) async {
    final db = await database;
    await db!.delete(
      'folders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllFolder() async {
    final db = await database;
    await db!.delete('folders');
  }
}
