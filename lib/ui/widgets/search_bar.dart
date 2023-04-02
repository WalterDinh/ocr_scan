import 'package:flutter/material.dart';
import 'package:my_app/ui/widgets/spacer.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    this.margin = const EdgeInsets.symmetric(horizontal: 28),
  });

  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      margin: margin,
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.search, size: 26),
          const HSpacer(13),
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                isDense: true,
                hintText: 'Search',
                contentPadding: EdgeInsets.zero,
                hintStyle: TextStyle(
                  fontSize: 14,
                  // color: AppColors.grey,
                  height: 1,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
