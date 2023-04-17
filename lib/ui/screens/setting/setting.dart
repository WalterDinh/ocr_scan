import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/ui/screens/setting/widgets/drop_down_language.dart';
import 'package:my_app/ui/screens/setting/widgets/item_setting.dart';
import 'package:my_app/ui/widgets/main_app_bar.dart';
import 'package:my_app/ui/widgets/spacer.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final double leadingWidth = 120;
  @override
  void initState() {
    scheduleMicrotask(() async {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        leadingWidth: leadingWidth,
        isBackButtonShowed: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0, top: 12),
          child: Text(
            'Settings',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        actions: const [
          IconButton(
              splashRadius: AppValues.iconSize_20,
              onPressed: AppNavigator.pop,
              icon: Icon(
                Icons.close,
                size: AppValues.iconSize_20,
                color: AppColors.black,
              )),
          HSpacer(8)
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ItemSetting(
              title: 'PDF & Display',
              iconName: AppImages.iconPage,
              onPress: () {}),
          ItemSetting(
            title: 'Language options',
            iconName: AppImages.iconTranslate,
            onPress: () {},
            rightView: const DropdownButtonLanguage(),
          ),
          ItemSetting(
              title: 'Privacy policy',
              iconName: AppImages.iconPrivacy,
              onPress: () {}),
          ItemSetting(
              title: 'Help',
              iconName: AppImages.iconHelpCircle,
              onPress: () {}),
          ItemSetting(
              title: 'Rate app', iconName: AppImages.iconStar, onPress: () {}),
          ItemSetting(
              title: 'Share this app',
              iconName: AppImages.iconShare,
              onPress: () {})
        ],
      ),
    );
  }
}
