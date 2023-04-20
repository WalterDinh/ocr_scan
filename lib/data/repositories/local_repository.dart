import 'package:my_app/data/source/local/local_data_source.dart';
import 'package:my_app/data/source/local/model/file_scan.dart';
import 'package:my_app/data/source/local/model/folder.dart';

abstract class LocalDataRepository {
  Future<List<Folder>> getAllFolder();

  Future<List<FileScan>> getFileScanByFolder({required int folderId});

  Future<List<FileScan>> getHistoryScan();

  Future<int> insertFile({required FileScan file});

  Future<int> insertFolder({required Folder folder});
  Future<void> deleteFolder({required int folderId});
  Future<void> updateFolder({required Folder folder});
}

class DataDefaultRepository extends LocalDataRepository {
  DataDefaultRepository({required this.localDataSource});

  final LocalDataSource localDataSource;

  @override
  Future<List<Folder>> getAllFolder() async {
    List<Folder> allFolder = await localDataSource.getAllFolders();

    return allFolder;
  }

  @override
  Future<List<FileScan>> getFileScanByFolder({required int folderId}) async {
    List<FileScan> listFile =
        await localDataSource.getListFileScanByFolder(folderId);

    return listFile;
  }

  @override
  Future<List<FileScan>> getHistoryScan() async {
    return [];
  }

  @override
  Future<void> deleteFolder({required int folderId}) async {
    await localDataSource.deleteFolder(folderId);
  }

  @override
  Future<int> insertFile({required FileScan file}) async {
    int fileId = await localDataSource.insertFileScan(file);

    return fileId;
  }

  @override
  Future<int> insertFolder({required Folder folder}) async {
    int folderId = await localDataSource.insertFolder(folder);

    return folderId;
  }

  @override
  Future<void> updateFolder({required Folder folder}) async {
    await localDataSource.updateFolder(folder);
  }
}
