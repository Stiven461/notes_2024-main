import 'package:flutter/material.dart';
import 'package:notes_2024/screens/widget/custom_textfield.dart';

class FormClients extends StatelessWidget {
  FormClients({super.key});

  final TextEditingController txtNombre = TextEditingController();
  final TextEditingController txtApellido = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplo Formulario'),
      ),
      body: ListView(
        children: [
          CustomTextField(
            hintText: 'Nombre',
            controller: txtNombre,
            icon: Icons.person,
          ),
          CustomTextField(
            hintText: 'Apellido',
            controller: txtApellido,
            icon: Icons.person_add,
          ),
        ],
      ),
    );
  }
}
