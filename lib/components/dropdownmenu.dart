import 'package:flutter/material.dart';

class dropDownMenu extends StatefulWidget {
  final String text;
  final List<String> menuList;

  const dropDownMenu({
    Key? key,
    required this.text,
    required this.menuList,
  }) : super(key: key);

  @override
  State<dropDownMenu> createState() => _dropDownMenuState();
}

class _dropDownMenuState extends State<dropDownMenu> {

    //Variable
  String? selectedVal = "";
  
  _createTutoriaState(){
    selectedVal = widget.menuList[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
              value: null,
              items: widget.menuList.map(
                (e) {
                  return DropdownMenuItem(child: Text(e), value: e);
                }
              ).toList(), 
              onChanged: (val) {
                setState(() {
                  selectedVal = val as String;
                });
              },
              icon: const Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.black
              ),
              dropdownColor: Colors.white,
              decoration: InputDecoration(
                labelText: widget.text,
                labelStyle: TextStyle(
                  fontSize: 15,
                )
              ),
            );;
  }
}