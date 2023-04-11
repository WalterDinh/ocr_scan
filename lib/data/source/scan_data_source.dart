import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_app/core/network.dart';

class ScanDataSource {
  ScanDataSource(this.networkManager);

  static const String url =
      'http://171.241.8.25:7007/Nhan_dang_tieng_viet/Springai99';

  final NetworkManager networkManager;

  Future<List<String>> getListText(File filePhoto) async {
    String fileName = filePhoto.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePhoto.path, filename: fileName),
    });
    final response = await networkManager.request(RequestMethod.post, url,
        data: formData,
        queryParameters: {'file_type': 'txt'},
        contentType: 'multipart/form-data');

    List<String> data = List<String>.from(response.data.map((x) => x));

    return data;
  }
}
