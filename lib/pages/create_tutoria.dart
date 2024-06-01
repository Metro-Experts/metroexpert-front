import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metro_experts/components/appBar.dart';
import 'package:metro_experts/components/multi_checkbox.dart';
import 'package:metro_experts/components/dropDownMenu.dart';

class CreateTutoria extends StatefulWidget {
  const CreateTutoria({super.key});

  @override
  State<CreateTutoria> createState() => _CreateTutoriaState();
}

class _CreateTutoriaState extends State<CreateTutoria> {
  //Variables de ejemplos para poder trabajar en esto
  List<String> categoryList = [
    "Categoría 1",
    "Categoría 2",
    "Categoría 3",
    "Categoría 4"
  ];
  List<String> subjectsList = [
    "Asignatura 1",
    "Asignatura 2",
    "Asignatura 3",
    "Asignatura 4"
  ];
  List<String> modalidadList = ["Presencial", "Virtual"];
  List<String> scheduleList = ["8:00AM", "9:00AM", "10:00AM", "3:00PM"];
  String? selectedVal = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(38.0),
          child: CustomAppBar(titleText: 'Crear Tutoría')),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(40),
        child: ListView(
          children: [
            dropDownMenu(
                text: "Selecciona una categoría: ", menuList: categoryList),
            const SizedBox(height: 50),
            dropDownMenu(
                text: "Selecciona una asignatura: ", menuList: subjectsList),
            const SizedBox(height: 50),
            const Text("Establezca su horario disponible:  "),
            const customMultiCheckBox(),
            const SizedBox(height: 20),
            dropDownMenu(
                text: "Selecciona un horario: ", menuList: scheduleList),
            const SizedBox(height: 50),
            TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], //solo números
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 5),
                    labelText: "Precio por hora:",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "\$",
                    hintStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ))),
            const SizedBox(height: 50),
            dropDownMenu(
                text: "Selecciona una modalidad: ", menuList: modalidadList),
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    "Cancelar",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: const Color(0xfffFF0000),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Crear",
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfff060B26),
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
