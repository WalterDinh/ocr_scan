import 'package:flutter/material.dart';

const String _imagePath = 'assets/images';

class _Image extends AssetImage {
  const _Image(String fileName) : super('$_imagePath/$fileName');
}

class AppImages {
  static const logo = _Image('logo_flutter.jpg');
  static const intro_page1 = _Image('intro_page1.png');
  static const intro_page2 = _Image('intro_page2.png');
  static const intro_page3 = _Image('intro_page3.png');
  // static const charmander = _Image('charmander.png');
  // static const squirtle = _Image('squirtle.png');
  // static const pokeball = _Image('pokeball.png');
  // static const male = _Image('male.png');
  // static const female = _Image('female.png');
  // static const dotted = _Image('dotted.png');
  // static const thumbnail = _Image('thumbnail.png');
  // static const pikloader = _Image('pika_loader.gif');

  static Future precacheAssets(BuildContext context) async {
    await precacheImage(logo, context);
  }
}
