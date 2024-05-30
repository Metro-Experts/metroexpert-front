import 'package:flutter/material.dart';

class customMultiCheckBox extends StatefulWidget {
  const customMultiCheckBox({super.key});

  @override
  State<customMultiCheckBox> createState() => _customMultiCheckBoxState();
}

class _customMultiCheckBoxState extends State<customMultiCheckBox> {

  List<String> selectedItems = [];

  void _showMultiSelect() async {
    final List <String> items = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
    ];

    final List<String>? results = await showDialog(
      context: context, 
      builder: (BuildContext context){
        return MultiSelect(items: items);
      });

      //Update
      if(results != null) {
        setState(() {
          selectedItems = results;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: _showMultiSelect,
            child: const Text('Seleccione aquí los días'),
          ),

          Wrap(
            children: selectedItems.map((e) => Chip(
              label: Text(e),
            )).toList(),
          ) 
        ],
      ),
    );
  }
}


class MultiSelect extends StatefulWidget {
  final List<String> items;
  const MultiSelect({Key? key, required this.items}) : super(key : key);

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {

  //Para cargar los items seleccionados en pantalla
  final List<String> selectedItems = [];

  void itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedItems.add(itemValue);
      } else {
        selectedItems.remove(itemValue);
      }
    }
  );
  }

  void cancel(){
    Navigator.pop(context);
  }

  void submit(){
    Navigator.pop(context, selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selecciona los días'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) => CheckboxListTile(
            value: selectedItems.contains(item), 
            title: Text(item),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (isChecked) => itemChange(item, isChecked!),
            )).toList(),
            )
          ),
        actions: [
          TextButton(
            onPressed: cancel,
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: submit, 
            child: const Text('Guardar')
          ),
        ],
        );
  }
}