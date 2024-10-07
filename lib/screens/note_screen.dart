import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_2024/controllers/categorias_controller.dart';
import 'package:notes_2024/models/category.dart';
import 'package:notes_2024/screens/categorias_screen.dart';
import 'package:notes_2024/screens/form.dart';
import 'package:notes_2024/screens/responsable.dart';
import 'package:notes_2024/screens/widget/custom_textfield.dart';
import 'package:notes_2024/screens/widget/note_dialog.dart';
import '../controllers/note_controller.dart';
import '../models/note_model.dart';

class NotesScreen extends StatelessWidget {
  final NoteController noteController = Get.put(NoteController());
  final CategoriasController categoriasController = Get.put(CategoriasController());

  NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas - P. Movil 2024'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showNoteDialog(context),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => ResponsableScreen());
            },
            icon: const Icon(Icons.person_add_alt),
          ),
        ],
      ),
      body: Column(
        children: [
          // Fila de botones para seleccionar categorías y "Mostrar Todas"
          Obx(() {
            if (categoriasController.categorias.isEmpty) {
              return const Center(child: CircularProgressIndicator()); // Muestra un indicador de carga si no hay categorías
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Botón para mostrar todas las notas
                  ElevatedButton(
                    onPressed: () {
                      noteController.clearFilter(); // Método para limpiar el filtro
                    },
                    child: const Text("Mostrar Todas"),
                  ),
                  ...categoriasController.categorias.map<Widget>((Categorias category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Filtra las notas por la categoría seleccionada
                          noteController.filterNotesByCategory(category.id);
                        },
                        child: Text(category.title), // Se eliminó el punto y coma aquí
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              hintText: 'Aquí buscando...',
              controller: searchController,
              isSearch: false,
              icon: Icons.search,
              onChanged: (value) {
                // Filtra las notas por búsqueda y la categoría seleccionada
                noteController.filterNotes(value);
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              // Verifica si hay notas filtradas
              if (noteController.filteredNotes.isEmpty) {
                return const Center(child: Text('No hay Notas'));
              }
              return ListView.builder(
                itemCount: noteController.filteredNotes.length,
                itemBuilder: (context, index) {
                  final note = noteController.filteredNotes[index];
                  return ListTile(
                    title: Text(note.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(note.content), // Mostrando el contenido
                        Text(
                          'Creada hace ${note.daysSinceCreation()} días',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _showDeleteConfirmation(context, note.id),
                    ),
                    onTap: () => _showNoteDialog(context, note: note, isEdit: true),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CategoriasScreen());
        },
        child: const Icon(Icons.category),
      ),
    );
  }

  // Función para mostrar el diálogo de confirmación antes de eliminar
  void _showDeleteConfirmation(BuildContext context, String noteId) {
    Get.defaultDialog(
      title: "Confirmar eliminación",
      middleText: "¿Estás seguro de que deseas eliminar esta nota?",
      textCancel: "Cancelar",
      textConfirm: "Eliminar",
      confirmTextColor: Colors.white,
      onConfirm: () {
        noteController.deleteNote(noteId);
        Get.back(); // Cerrar el diálogo después de eliminar
        Get.snackbar(
          "Nota eliminada",
          "La nota se ha eliminado correctamente.",
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      onCancel: () => Get.back(),
    );
  }

  // Función para mostrar el diálogo de agregar/editar notas
  void _showNoteDialog(BuildContext context, {Note? note, bool isEdit = false}) {
    showDialog(
      context: context,
      builder: (context) {
        return NoteDialog(note: note, isEdit: isEdit);
      },
    );
  }
}
