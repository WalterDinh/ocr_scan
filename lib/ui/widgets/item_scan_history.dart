import 'package:flutter/material.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';

class ItemScanHistory extends StatelessWidget {
  final String fileName;
  final String dateTime;
  final String pathUrl;
  final Function() onDownLoad;
  final Function() onShare;
  final Function() onShowMoreOption;
  final Function()? onPressItem;

  const ItemScanHistory(
      {super.key,
      required this.fileName,
      required this.dateTime,
      required this.pathUrl,
      required this.onDownLoad,
      required this.onShare,
      required this.onShowMoreOption,
      this.onPressItem});

  @override
  Widget build(BuildContext context) {
    return Ripple(
      onTap: onPressItem,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(1, 3))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Image(
                      width: 56,
                      height: 64,
                      fit: BoxFit.cover,
                      image: AppImages.logo,
                    ),
                  ),
                  _buildInfoScanHistory()
                ],
              )),
              Ripple(
                  onTap: onShowMoreOption, child: const Icon(Icons.more_vert))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoScanHistory() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              fileName,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            Text(
              dateTime,
              style: const TextStyle(fontSize: 12),
            ),
            const VSpacer(8),
            Row(
              children: [
                Ripple(
                  onTap: onDownLoad,
                  child: const Icon(Icons.download),
                ),
                const HSpacer(8),
                Ripple(
                  onTap: onShare,
                  child: const Icon(Icons.share),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
