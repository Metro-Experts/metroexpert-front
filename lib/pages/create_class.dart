// ignore_for_file: use_build_context_synchronously, avoid_print, use_full_hex_values_for_flutter_colors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metro_experts/components/custom_text_field.dart';
import 'package:metro_experts/components/drawer_menu.dart';
import 'package:metro_experts/components/dropDownMenu.dart';
import 'package:metro_experts/controllers/create_class_page_controller.dart';
import 'package:metro_experts/model/user_model.dart';
import 'package:metro_experts/pages/home_page.dart';
import 'package:provider/provider.dart';

class CreateClass extends StatefulWidget {
  const CreateClass({super.key});

  @override
  State<CreateClass> createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  @override
  void initState() {
    super.initState();
    Provider.of<CreateClassPageController>(context, listen: false).reset();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserOnSession, CreateClassPageController>(
      builder: (context, userOnSessionConsumer,
          createClassPageControllerConsumer, _) {
        return Scaffold(
          appBar: AppBar(),
          drawer: const DrawerMenu(),
          backgroundColor: Colors.white,
          body: Container(
            padding: const EdgeInsets.all(40),
            child: ListView(
              children: [
                DropDownMenu(
                  text: "Selecciona una categoría: ",
                  menuList: createClassPageControllerConsumer.categoryList,
                  onSelectionChanged: (val) {
                    setState(
                      () {
                        createClassPageControllerConsumer.categorySelection =
                            val!;
                        createClassPageControllerConsumer.subjectsList(
                            createClassPageControllerConsumer
                                .categorySelection);
                      },
                    );
                  },
                ),
                const SizedBox(height: 50),
                DropDownMenu(
                  text: "Selecciona una asignatura: ",
                  menuList: createClassPageControllerConsumer.categoryChildList,
                  onSelectionChanged: (val) {
                    setState(
                      () {
                        print(createClassPageControllerConsumer
                            .categoryChildList);
                        createClassPageControllerConsumer.subject = val;
                      },
                    );
                  },
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  labelText: "Dia 1",
                  placeholder: 'Lunes',
                  isPasswordTextField: false,
                  controller: createClassPageControllerConsumer.dia1Controller,
                ),
                CustomTextField(
                  labelText: "Hora 1",
                  placeholder: '17:00',
                  isPasswordTextField: false,
                  controller: createClassPageControllerConsumer.hora1Controller,
                ),
                CustomTextField(
                  labelText: "Dia 2",
                  placeholder: 'Martes',
                  isPasswordTextField: false,
                  controller: createClassPageControllerConsumer.dia2Controller,
                ),
                CustomTextField(
                  labelText: "Hora 2",
                  placeholder: '21:00',
                  isPasswordTextField: false,
                  controller: createClassPageControllerConsumer.hora2Controller,
                ),
                const SizedBox(height: 50),
                TextField(
                  controller: createClassPageControllerConsumer.priceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 5),
                    labelText: "Precio por hora:",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "\$",
                    hintStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                DropDownMenu(
                  text: "Selecciona una modalidad: ",
                  menuList: createClassPageControllerConsumer.modalidadList,
                  onSelectionChanged: (val) {
                    setState(() {
                      createClassPageControllerConsumer.modality = val!;
                    });
                  },
                ),
                const SizedBox(height: 80),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        createClassPageControllerConsumer.createClass(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xfff060B26),
                        padding: const EdgeInsets.symmetric(horizontal: 64),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        "Crear",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color(0xfffFF0000),
                      ),
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
