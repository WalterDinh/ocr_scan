import 'package:flutter/material.dart';

const String _imagePath = 'assets/images';

class _Image extends AssetImage {
  const _Image(String fileName) : super('$_imagePath/$fileName');
}

class AppImages {
  static const logo = _Image('logo_flutter.jpg');
  static const intro_page1 = _Image('intro_page1.png');
  static const intro_page2 = _Image('intro_page2.png');
  static const intro_page3 = _Image('intro_page3.png');
  static const iconFolder = '$_imagePath/folder.svg';
  static const iconEdit = '$_imagePath/icon_edit.svg';
  static const iconShare = '$_imagePath/icon_share.svg';
  static const iconMore = '$_imagePath/icon_more.svg';
  static const iconScan = '$_imagePath/icon_scan.svg';
  static const iconSearch = '$_imagePath/icon_search.svg';
  static const iconMove = '$_imagePath/icon_move.svg';
  static const iconDelete = '$_imagePath/icon_delete.svg';
  static const iconFolderAdd = '$_imagePath/folder_add.svg';

  static Future precacheAssets(BuildContext context) async {
    await precacheImage(logo, context);
  }
}
