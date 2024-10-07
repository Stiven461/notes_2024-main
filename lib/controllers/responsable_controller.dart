import 'package:get/get.dart';
import 'package:notes_2024/models/resposanble_model.dart';
import 'package:notes_2024/services/responsable_services.dart';

class ResponsableController extends GetxController {
  final ResponsableService _responsableService = ResponsableService();
  RxList<Responsable> responsables = <Responsable>[].obs; 


  @override
  void onInit() {
    super.onInit();
    fetchResponsable(); 
  }
 
  void fetchResponsable() async {
    responsables.value = await _responsableService.getResponsable();
  
  }

 
  Future<void> addResponsable(Responsable responsable) async {
    await _responsableService.addResponsable(responsable);
    fetchResponsable(); 
  }

 
}
