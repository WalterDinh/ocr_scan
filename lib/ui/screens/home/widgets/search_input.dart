import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    super.key,
    this.onPressInput,
    this.onPressIconSearch,
    required this.hintText,
  });

  final Function()? onPressInput;
  final Function()? onPressIconSearch;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          elevation: 4.0,
          shadowColor: Colors.grey[200],
          child: TextField(
            onTap: onPressInput,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              // add IconButton as suffix icon
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: onPressIconSearch,
              ),
            ),
          ),
        ));
  }
}
