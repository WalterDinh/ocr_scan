import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:share_plus/share_plus.dart';

class PdfApi {
  static Future<File> generateCenteredText(String text) async {
    // making a pdf document to store a text and it is provided by pdf pakage
    final pdf = Document();

    // Text is added here in center
    pdf.addPage(
      Page(
        build: (context) => Text(text,
            style: const TextStyle(fontSize: 14), textAlign: TextAlign.left),
      ),
    );

    // passing the pdf and name of the docoment to make a direcotory in  the internal storage
    return saveDocument(name: 'my_example.pdf', pdf: pdf);
  }

  // it will make a named dircotory in the internal storage and then return to its call
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
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

  static Future shareDocument() async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/my_example.pdf';

    await Share.shareXFiles([XFile(filePath)]);
  }

  static shareTxtFile(List<String> dataText) async {
    String dataConverted =
        dataText.reduce((value, element) => '$value\n$element');
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/temp.txt');
    await file.writeAsString(dataConverted);
    await Share.shareXFiles([XFile(file.path)]);
  }

  static Future<File?> copyFileDocumentToExternalStorage({
    required File file,
  }) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final externalDir = await getExternalStorageDirectory();
    if (externalDir == null) {
      return null;
    }
    final newPath = "${externalDir.path}/DocumentScan/document_$timestamp.pdf";
    File file = File(newPath);
    if (!await file.exists()) {
      file.create(recursive: true);
    }
    await file.copy(newPath);

    return file;
  }

  static Future<File?> saveDocumentToExternal({
    required String text,
    required File fileInput,
  }) async {
    final bytes = await fileInput.readAsBytes();

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final externalDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    if (externalDir == null) {
      return null;
    }
    final newPath = "${externalDir.path}/document_$timestamp.pdf";
    final file = File(newPath);
    await file.writeAsBytes(bytes);

    return file;
  }
}
