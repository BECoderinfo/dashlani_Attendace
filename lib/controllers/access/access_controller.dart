import 'package:attendance_app/utils/import.dart';

import '../../services/api_service.dart';

class AccessController extends GetxController {
  final BuildContext ctx;

  AccessController({required this.ctx});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  getData() async {
    try {
      var res = await ApiService.getApi(
          Apis.getById(id: AppVariables.box.read(StorageKeys.aId)), ctx);
      if (res != null) {
        AppVariables.box.write(StorageKeys.access, res['user']['access']);
        AppVariables.box.write(StorageKeys.aRole, res['user']['role']);

        log(AppVariables.box.read(StorageKeys.access).toString());

        if (AppVariables.box.read(StorageKeys.access)) {
          (Routes.navigation).offAllNamed();
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
