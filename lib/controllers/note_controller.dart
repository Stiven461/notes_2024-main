import 'package:get/get.dart';
import '../models/note_model.dart';
import '../services/note_service.dart';

class NoteController extends GetxController {
  final NoteService _noteService = NoteService();
  RxList<Note> notes = <Note>[].obs; // Todas las notas
  RxList<Note> filteredNotes = <Note>[].obs; // Notas filtradas

  @override
  void onInit() {
    super.onInit();
    fetchNotes(); // Obtener todas las notas al iniciar
  }

  //-------------------------------------------
  void clearFilter() {
    filteredNotes.value = notes; // Restablecer las notas filtradas a todas las notas
  }
  //-------------------------------------------

  // Obtener todas las notas desde Firestore a través del servicio
  void fetchNotes() async {
    notes.value = await _noteService.getNotes();
    filteredNotes.value =
        notes; // Inicialmente, las notas filtradas son todas las notas
  }

  // Método para filtrar las notas
  void filterNotes(String query) {
    if (query.isEmpty) {
      // Si el campo de búsqueda está vacío, mostrar todas las notas
      filteredNotes.value = notes;
    } else {
      // Filtrar las notas basadas en el título o contenido
      filteredNotes.value = notes.where((note) {
        return note.title.toLowerCase().contains(query.toLowerCase()) ||
            note.content.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  //-------------------------------------------
  // Método para filtrar notas por categoría
  void filterNotesByCategory(String categoryId) {
    if (categoryId.isEmpty) {
      filteredNotes.value = notes; // Mostrar todas las notas si no hay categoría
    } else {
      filteredNotes.value = notes.where((note) => note.categoryId == categoryId).toList();
    }
  }
  //-------------------------------------------

  // Agregar una nota a través del servicio
  Future<void> addNote(Note note) async {
    await _noteService.addNote(note);
    fetchNotes(); // Refrescar la lista de notas después de agregar
  }

  // Actualizar una nota a través del servicio
  Future<void> updateNote(Note note) async {
    await _noteService.updateNote(note);
    fetchNotes(); // Refrescar la lista de notas después de actualizar
  }

  // Eliminar una nota a través del servicio
  Future<void> deleteNote(String noteId) async {
    await _noteService.deleteNote(noteId);
    fetchNotes(); // Refrescar la lista de notas después de eliminar
  }



}
