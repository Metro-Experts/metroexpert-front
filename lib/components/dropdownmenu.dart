import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {
  final String text;
  final List<String> menuList;
  final void Function(String?) onSelectionChanged;
  final String? selectedValue;

  const DropDownMenu({
    super.key,
    required this.text,
    required this.menuList,
    required this.onSelectionChanged,
    this.selectedValue,
  });

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String? selectedVal;

  @override
  void initState() {
    super.initState();
    selectedVal = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: selectedVal,
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
            selectedVal = value;
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
