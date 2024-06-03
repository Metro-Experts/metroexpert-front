import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {
  final String text;
  final List<String> menuList;
  final void Function(String?) onSelectionChanged;

  const DropDownMenu({
    super.key,
    required this.text,
    required this.menuList,
    required this.onSelectionChanged,
  });

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  //Variable
  String? selectedVal = "";

  // _createTutoriaState() {
  //   selectedVal = widget.menuList[0];
  // }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: null,
      items: widget.menuList.map(
        (e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e),
          );
        },
      ).toList(),
      onChanged: (value) {
        setState(
          () {
            selectedVal = value as String;
            widget.onSelectionChanged(selectedVal);
          },
        );
      },
      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.black),
      dropdownColor: Colors.white,
      decoration: InputDecoration(
        labelText: widget.text,
        labelStyle: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }
}
