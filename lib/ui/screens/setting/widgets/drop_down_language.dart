import 'package:flutter/material.dart';

const List<String> list = <String>['EN', 'VN'];

class DropdownButtonLanguage extends StatefulWidget {
  const DropdownButtonLanguage({super.key});

  @override
  State<DropdownButtonLanguage> createState() => _DropdownButtonLanguageState();
}

class _DropdownButtonLanguageState extends State<DropdownButtonLanguage> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down, color: Theme.of(context).primaryColor),
      elevation: 16,
      style: TextStyle(color: Theme.of(context).primaryColor),
      underline: Container(
        height: 0,
        color: Colors.transparent,
      ),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
