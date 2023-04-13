import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/core/values/app_values.dart';

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
          child: TextField(
            onTap: onPressInput,
            decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.lightGreen,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                hintText: hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.grey, fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: IconButton(
                  icon: SvgPicture.asset(
                    AppImages.iconSearch,
                    width: AppValues.iconSize_20,
                    height: AppValues.iconSize_20,
                  ),
                  onPressed: onPressIconSearch,
                )),
          ),
        ));
  }
}
