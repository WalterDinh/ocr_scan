part of '../scan_result.dart';

class ScanResultImage extends StatefulWidget {
  const ScanResultImage({Key? key}) : super(key: key);

  @override
  State<ScanResultImage> createState() => _ScanResultImageScreenState();
}

class _ScanResultImageScreenState extends State<ScanResultImage> {
  @override
  Widget build(BuildContext context) {
    return CurrentScanPhotoSelector((scanPhoto) {
      print("scanPhoto ${scanPhoto!.thumbnailData}");

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(),
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Image.asset(
            'assets/images/logo_flutter.jpg',
            fit: BoxFit.cover,
          ),
        ),
      );
    });
  }
}
