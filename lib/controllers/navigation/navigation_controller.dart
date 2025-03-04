import '../../utils/import.dart';

class BottomNavController extends GetxController {
  RxInt selectedIndex = 0.obs; // Observable variable for the selected index

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  // Method to change the selected index
  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
