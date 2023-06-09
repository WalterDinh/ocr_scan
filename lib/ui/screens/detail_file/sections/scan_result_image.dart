part of '../detail_file.dart';

class ScanResultImage extends StatefulWidget {
  const ScanResultImage({Key? key}) : super(key: key);

  @override
  State<ScanResultImage> createState() => _ScanResultImageScreenState();
}

class _ScanResultImageScreenState extends State<ScanResultImage> {
  late PDFViewController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.darkGreen),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: CurrentScanDataPDFSelector((file) {
          if (file == null) {
            return const Icon(
              Icons.warning_amber_rounded,
              size: 60,
              color: Colors.black26,
            );
          }

          return PDFView(
            filePath: file.path,
            autoSpacing: true,
            enableSwipe: true,
            swipeHorizontal: true,
            fitEachPage: true,
            nightMode: false,
            onViewCreated: (controller) =>
                setState(() => this.controller = controller),
          );
        }),
      ),
    );
  }
}
