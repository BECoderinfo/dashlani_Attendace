import 'package:attendance_app/utils/import.dart';

class NoteController extends GetxController {
  final BuildContext ctx;

  NoteController({required this.ctx});

  TextEditingController noteController = TextEditingController();

  RxString noteError = ''.obs;

  RxBool isSending = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }

  checkValidation() {
    if (noteController.text.trim().isEmpty) {
      noteError.value = 'Please enter note';
      return false;
    }
  }

  sendNote() {}
}
