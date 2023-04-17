import 'package:flutter/material.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/ui/widgets/modal.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';

enum MimeType { image, pdf, txt }

class SelectMimeTypeModal extends StatefulWidget {
  const SelectMimeTypeModal({
    required this.title,
    required this.onTakeMimeType,
  });

  final String title;
  final Function(MimeType) onTakeMimeType;

  @override
  State<SelectMimeTypeModal> createState() => _SelectMimeTypeModalState();
}

class _SelectMimeTypeModalState extends State<SelectMimeTypeModal> {
  @override
  Widget build(BuildContext context) {
    return Modal(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.title,
                style: Theme.of(context).textTheme.headlineMedium),
            const VSpacer(24),
            Ripple(
                onTap: () => _onTakeMimeType(MimeType.image),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.image,
                      size: AppValues.iconSize_28,
                    ),
                    HSpacer(12),
                    Text('Image')
                  ],
                )),
            const VSpacer(16),
            Ripple(
                onTap: () => _onTakeMimeType(MimeType.pdf),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.picture_as_pdf,
                      size: AppValues.iconSize_28,
                    ),
                    HSpacer(12),
                    Text('PDF')
                  ],
                )),
            const VSpacer(16),
            Ripple(
                onTap: () => _onTakeMimeType(MimeType.txt),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.text_snippet,
                      size: AppValues.iconSize_28,
                    ),
                    HSpacer(12),
                    Text('TXT')
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void _onTakeMimeType(MimeType mimeType) {
    widget.onTakeMimeType(mimeType);
  }
}
