import 'package:flutter/material.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';

class ModalCreateFolder extends StatefulWidget {
  final String initialValue;
  final Function(String text) onSummit;

  const ModalCreateFolder(
      {Key? key, required this.initialValue, required this.onSummit})
      : super(key: key);

  @override
  ModalCreateFolderState createState() => ModalCreateFolderState();
}

class ModalCreateFolderState extends State<ModalCreateFolder> {
  late TextEditingController _controller;
  String text = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      text = widget.initialValue;
    });
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      insetPadding: const EdgeInsets.all(24.0),
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      title: Text(
        'Create new folder',
        style: Theme.of(context).textTheme.labelLarge,
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      content: SizedBox(
        width: double.maxFinite,
        child: TextField(
          onChanged: (value) {
            setState(() {
              text = value;
            });
          },
          cursorColor: AppColors.black,
          decoration: InputDecoration(
            isDense: true,
            suffixIconConstraints:
                const BoxConstraints(minHeight: 24, minWidth: 24),
            suffixIcon: text.isNotEmpty
                ? Ripple(
                    rippleRadius: AppValues.iconSize_14,
                    onTap: () {
                      _controller.text = '';
                    },
                    child: const Icon(
                      Icons.close,
                      size: AppValues.iconSize_20,
                      color: AppColors.black,
                    ))
                : null,
            contentPadding: const EdgeInsets.fromLTRB(0, 8, 12, 8),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.semiGrey),
            ),
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
          controller: _controller,
        ),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(0, 4, 24, 24),
      actions: [
        Ripple(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        const HSpacer(16),
        Ripple(
          onTap: () {
            String editedText = _controller.text;
            widget.onSummit(editedText);
            Navigator.of(context).pop();
          },
          child: Text(
            'Create',
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
