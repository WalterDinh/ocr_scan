part of '../scan_result.dart';

class ScanResultText extends StatefulWidget {
  const ScanResultText({Key? key}) : super(key: key);

  @override
  State<ScanResultText> createState() => _ScanResultTextState();
}

class _ScanResultTextState extends State<ScanResultText> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0), border: Border.all()),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: CurrentScanDataTextSelector((text) {
              if (text.isNotEmpty) {
                return Text(
                  text,
                  style: const TextStyle(height: 1.5),
                );
              }

              return Center(
                  child: Text(
                'Can\'t detect text',
                style: Theme.of(context).textTheme.bodyLarge,
              ));
            }),
          ),
        ));
  }
}
