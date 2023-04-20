import 'package:flutter/material.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/ui/widgets/ripple.dart';

import '../../widgets/main_app_bar.dart';

class EditScanResultScreen extends StatefulWidget {
  const EditScanResultScreen(
      {Key? key, required this.dataText, this.onTextChange})
      : super(key: key);

  final String dataText;
  final Function(String text)? onTextChange;

  @override
  State<EditScanResultScreen> createState() => _EditScanResultScreenState();
}

class _EditScanResultScreenState extends State<EditScanResultScreen> {
  final _textEditController = TextEditingController();

  @override
  void initState() {
    _textEditController.text = widget.dataText;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: Ripple(
                  onTap: _onPressDone,
                  child: const Text("Done"),
                ),
              ),
            )
          ]),
      body: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0), border: Border.all()),
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: TextField(
            controller: _textEditController,
            style: const TextStyle(height: 1.5),
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
        ),
      ),
    );
  }

  void _onPressDone() {
    widget.onTextChange?.call(_textEditController.text);
    AppNavigator.pop();
  }
}
