import 'dart:io';

import 'package:my_app/data/source/scan_data_source.dart';

abstract class ScanPhotoRepository {
  Future<List<String>> getTextFromImage(File? filePhoto);
}

class ItemDefaultRepository extends ScanPhotoRepository {
  ItemDefaultRepository({required this.scanDataSource});

  final ScanDataSource scanDataSource;

  @override
  Future<List<String>> getTextFromImage(File? filePhoto) async {
    if (filePhoto != null) {
      final dataScan = await scanDataSource.getListText(filePhoto);

      return dataScan;
    } else {
      return [];
    }
  }
}
