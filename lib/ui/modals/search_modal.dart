import 'package:flutter/material.dart';
import 'package:my_app/ui/widgets/modal.dart';
import 'package:my_app/ui/widgets/search_bar.dart';

class SearchBottomModal extends StatelessWidget {
  const SearchBottomModal({super.key});

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;

    return Modal(
      child: Flexible(
        child: Padding(
          padding:
              EdgeInsets.fromLTRB(26, 14, 26, 14 + viewInsets + safeAreaBottom),
          child: const SearchBar(margin: EdgeInsets.zero),
        ),
      ),
    );
  }
}
