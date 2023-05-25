import 'dart:convert';
import 'dart:io';

import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class PdfApi {
  static Future<File> generateCenteredText(String text) async {
    // making a pdf document to store a text and it is provided by pdf pakage
    final pdf = pw.Document();

    final ttf = pw.Font.ttf(
        await rootBundle.load('assets/fonts/EncodeSans-Regular.ttf'));
    // Text is added here in center
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Text(text,
            style: const pw.TextStyle(fontSize: 14),
            textAlign: pw.TextAlign.left),
      ),
    );

    // passing the pdf and name of the docoment to make a direcotory in  the internal storage
    return saveDocument(name: 'temp.pdf', pdf: pdf);
  }

  // it will make a named dircotory in the internal storage and then return to its call
  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    // pdf save to the variable called bytes
    final bytes = await pdf.save();

    // here a beautiful pakage  path provider helps us and take dircotory and name of the file  and made a proper file in internal storage
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    // reterning the file to the top most method which is generate centered text.
    return file;
  }

  static Future shareDocument(String dataText) async {
    final file = await generateCenteredText(dataText);

    await Share.shareXFiles([XFile(file.path)]);
  }

  static shareTxtFile(String dataText) async {
    // String dataConverted =
    //     dataText.reduce((value, element) => '$value\n$element');
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/temp.txt');
    await file.writeAsString(dataText);
    await Share.shareXFiles([XFile(file.path)]);
  }

  static Future<bool> savePdfToExternal({required String text}) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Text(text,
            style: const pw.TextStyle(fontSize: 14),
            textAlign: pw.TextAlign.left),
      ),
    );
    final bytes = await pdf.save();

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileName = 'document_$timestamp.pdf';
    try {
      await DocumentFileSavePlus.saveFile(bytes, fileName, 'appliation/pdf');

      return true;
    } on PlatformException catch (e) {
      return false;
    }

    // FIXME: if DocumentFileSavePlus doesn't work then try CRFileSaver
    // print('file input ${fileInput.path}');
    // try {
    //   final file = await CRFileSaver.saveFile(
    //     fileInput.path,
    //     destinationFileName: fileName,
    //   );
    //   print('Saved to $file');
    //
    //   return true;
    // } on PlatformException catch (e) {
    //   print('file saving error: ${e.code}');
    //
    //   return false;
    // }
  }

  static Future<bool> saveTxtToExternal({required String text}) async {
    final bytes = utf8.encode(text);
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileName = 'document_$timestamp.txt';
    try {
      await DocumentFileSavePlus.saveFile(
          Uint8List.fromList(bytes), fileName, 'text/plain');

      return true;
    } on PlatformException catch (e) {
      return false;
    }
  }
}
