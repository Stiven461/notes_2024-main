import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_2024/controllers/note_controller.dart';
import 'package:notes_2024/controllers/categorias_controller.dart';
import 'package:notes_2024/models/note_model.dart';
import 'package:notes_2024/models/category.dart';
import 'package:notes_2024/screens/widget/custom_textfield.dart';

class NoteDialog extends StatelessWidget {
  final Note? note;
  final bool isEdit;
  final NoteController noteController = Get.find();
  final CategoriasController categoriasController = Get.find();

  // Cambiar a RxString para reactividad
  final RxString selectedCategoryId = ''.obs; 

  NoteDialog({super.key, this.note, this.isEdit = false}) {
    // Inicializar selectedCategoryId con la categoría existente si se está editando
    if (note != null) {
      selectedCategoryId.value = note!.categoryId ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: note?.title ?? '');
    TextEditingController contentController =
        TextEditingController(text: note?.content ?? '');

    return AlertDialog(
      title: Text(isEdit ? 'Editar Nota' : 'Agregar Nota'),
      content: SingleChildScrollView(
        // Asegura que el contenido sea desplazable si es necesario
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              hintText: 'Título',
              controller: titleController,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: 'Contenido',
              controller: contentController,
            ),
            const SizedBox(height: 10),
            Obx(() {
              if (categoriasController.categorias.isEmpty) {
                return const Text('No hay categorías disponibles.');
              }
              return DropdownButton<String>(
                value: selectedCategoryId.value.isNotEmpty ? selectedCategoryId.value : null,
                onChanged: (value) {
                  if (value != null) {
                    selectedCategoryId.value = value; // Actualizar el valor reactivo
                  }
                },
                items: categoriasController.categorias.map((Categorias category) {
                  return DropdownMenuItem<String>(
                    value: category.id,
                    child: Text(category.title),
                  );
                }).toList(),
                hint: const Text('Seleccionar Categoría'),
              );
            }),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          child: Text(isEdit ? 'Actualizar' : 'Guardar'),
          onPressed: () {
            if (isEdit) {
              noteController.updateNote(
                Note(
                  id: note!.id,
                  title: titleController.text,
                  content: contentController.text,
                  date: DateTime.now(),
                  categoryId: selectedCategoryId.value, // Usar el valor reactivo
                ),
              );
            } else {
              noteController.addNote(
                Note(
                  id: '',
                  title: titleController.text,
                  content: contentController.text,
                  date: DateTime.now(),
                  categoryId: selectedCategoryId.value, // Usar el valor reactivo
                ),
              );
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
