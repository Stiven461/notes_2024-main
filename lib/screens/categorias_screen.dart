import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_2024/controllers/categorias_controller.dart';
import 'package:notes_2024/models/category.dart';
import 'package:notes_2024/screens/widget/custom_textfield.dart';

class CategoriasScreen extends StatelessWidget {
  CategoriasScreen({super.key});
  final CategoriasController _categoriacontoller =
      Get.put(CategoriasController());

  @override
  Widget build(BuildContext context) {
    TextEditingController txtCategoria = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Categorias'),
      ),
      body: ListView(
        children: [
          CustomTextField(
              hintText: 'Nombre Categoria', controller: txtCategoria),
          ElevatedButton(
              onPressed: () {
                _categoriacontoller.addCategorias(
                    Categorias(id: '', title: txtCategoria.text));
                Get.back();
              },
              child: const Text('Guardar'))
        ],
      ),
    );
  }
}
