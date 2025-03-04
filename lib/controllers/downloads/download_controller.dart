import 'package:attendance_app/modals/download/download_modal.dart';

import '../../services/api_service.dart';
import '../../utils/import.dart';

class DownloadController extends GetxController {
  final BuildContext ctx;

  DownloadController({required this.ctx});

  RxList<DownloadModal> downloads = <DownloadModal>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getDownloads();
  }

  getDownloads() async {
    try {
      var res = await ApiService.getApi(
          Apis.download(id: AppVariables.box.read(StorageKeys.aId)), ctx);

      if (res != null) {
        print('hi');

        res.forEach((e) {
          downloads.add(DownloadModal.fromJson(e));
        });
        print("object");
        ShowToast.showSuccessGfToast(
            msg: "Documents fetched successfully", ctx: ctx);
      }
    } catch (e) {
      print(e);
      ShowToast.showFailedGfToast(msg: e.toString(), ctx: ctx);
    }
  }

  void previewDocument(DownloadModal document) {
    Get.snackbar('Preview', 'Opening ${document.documentName}...');
    // Logic to open the document in a viewer
    // Example: Open URL in browser
    // launchUrl(Uri.parse(document.documentUrl));
  }

  // Download document
  void downloadDocument(DownloadModal document) {
    Get.snackbar('Download', 'Downloading ${document.documentName}...');
    // Logic to handle file download
    // Example: Use Dio or similar packages for downloading files
  }

  void downloadFile({required String url}) {}
}
