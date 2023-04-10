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
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Text(
          "A Simple PDF File This is a small demonstration .pdf file - just for use in the Virtual Mechanics tutorials. More text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. Boring, zzzzz. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. Even more. Continued on page 2 ...",
          style: TextStyle(height: 1.5),
        ),
      ),
    );
  }
}
