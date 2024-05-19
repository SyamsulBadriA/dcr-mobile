import 'package:flutter/material.dart';

const List<String> list = <String>['10', '20', '42', '75'];

class DropdownMenuExample extends StatelessWidget {
  final String dropdownValue;
  final ValueChanged<String> onChanged;

  const DropdownMenuExample({
    required this.dropdownValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          onChanged: (String? value) {
            if (value != null) {
              onChanged(value);
            }
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(value),
              ),
            );
          }).toList(),
          isExpanded: true,
        ),
      ),
    );
  }
}
