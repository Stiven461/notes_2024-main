import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_2024/controllers/responsable_controller.dart';
import 'package:notes_2024/models/resposanble_model.dart';
import 'package:notes_2024/screens/widget/custom_textfield.dart';

class ResponsableScreen extends StatelessWidget {
  ResponsableScreen({super.key});
  final ResponsableController responsableController =
      Get.put(ResponsableController());

  @override
  Widget build(BuildContext context) {
    TextEditingController txtName = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Responsables'),
      ),
      body: ListView(
        children: [
          CustomTextField(hintText: 'Nombre', controller: txtName),
          ElevatedButton(
              onPressed: () {
                responsableController
                    .addResponsable(Responsable(id: '', name: txtName.text));
                Get.back();
              },
              child: const Text('Guardar'))
        ],
      ),
    );
  }
}
