import 'dart:io';

import 'package:attendance_app/utils/import.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProfileController extends GetxController {
  RxInt currentTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void changeTab({required int index}) {
    currentTab.value = index;
  }

  // Preview document
  void previewDocument({required String uri}) async {
    // Logic to open the document in a viewer
    // Example: Open URL in browser
    // launchUrl(Uri.parse(document.documentUrl));
    final Uri url = Uri.parse(uri);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch $url');
    }
  }

  // Download document
  void downloadDocument({required String uri, required String name}) async {
    try {
      final Dio dio = Dio();

      Directory? downloadsDirectory;
      if (Platform.isAndroid) {
        downloadsDirectory = await getExternalStorageDirectory();
      } else if (Platform.isIOS) {
        downloadsDirectory = await getApplicationDocumentsDirectory();
      }

      if (downloadsDirectory == null) {
        Get.snackbar('Error', 'Unable to access the downloads directory.');
        return;
      }

      final String savePath =
          '${downloadsDirectory.path}/$name.pdf'; // Update path as needed

      await dio.download(
        uri,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print(
                'Downloading: ${(received / total * 100).toStringAsFixed(0)}%');
          }
        },
      );

      Get.snackbar('Success', '$name downloaded successfully.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to download document.');
      print('Download error: $e');
    }
  }
}
