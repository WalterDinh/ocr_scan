import 'package:my_app/data/source/local/local_data_source.dart';
import 'package:my_app/data/source/local/model/file_scan.dart';
import 'package:my_app/data/source/local/model/folder.dart';
import 'package:my_app/data/source/local/model/search_history.dart';

abstract class LocalDataRepository {
  Future<List<Folder>> getAllFolder();

  Future<List<FileScan>> getFileScanByFolder({required int folderId});

  Future<List<FileScan>> getHistoryScan();

  Future<int> insertFile({required FileScan file});

  Future<int> insertFolder({required Folder folder});

  Future<void> deleteFolder({required int folderId});

  Future<void> updateFolder({required Folder folder});

  Future<void> deleteFile({required FileScan file});

  Future<void> updateFile({required FileScan file, Folder? folder});

  Future<List<FileScan>> getAllFile();

  Future<int> insertSearchHistory({required SearchHistory dataSearch});

  Future<void> deleteDataSearchHistory({required int idSearch});

  Future<List<SearchHistory>> getAllSearchHistory();

  Future<void> deleteOldestDataSearchHistory();

  Future<List<FileScan>> getDataSearchFileScan(String textSearch);

  Future<List<Folder>> getDataSearchFolder(String textSearch);
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

  @override
  Future<List<FileScan>> getAllFile() async {
    List<FileScan> allFile = await localDataSource.getAllFileScan();

    return allFile;
  }

  @override
  Future<void> deleteFile({required FileScan file}) async {
    await localDataSource.deleteFile(file);
  }

  @override
  Future<void> updateFile({required FileScan file, Folder? folder}) async {
    await localDataSource.updateFile(file, folder);
  }

  @override
  Future<int> insertSearchHistory({required SearchHistory dataSearch}) async {
    int searchId = await localDataSource.insertSearchHistory(dataSearch);

    return searchId;
  }

  @override
  Future<void> deleteDataSearchHistory({required int idSearch}) async {
    await localDataSource.deleteHistorySearch(idSearch);
  }

  @override
  Future<void> deleteOldestDataSearchHistory() async {
    await localDataSource.deleteOldestHistorySearch();
  }

  @override
  Future<List<SearchHistory>> getAllSearchHistory() async {
    List<SearchHistory> allFile = await localDataSource.getAllHistorySearch();

    return allFile;
  }

  @override
  Future<List<FileScan>> getDataSearchFileScan(String textSearch) async {
    List<FileScan> allFile =
        await localDataSource.getListFileScanBySearch(textSearch);

    return allFile;
  }

  @override
  Future<List<Folder>> getDataSearchFolder(String textSearch) async {
    List<Folder> allFolder =
        await localDataSource.getListFolderBySearch(textSearch);

    return allFolder;
  }
}
