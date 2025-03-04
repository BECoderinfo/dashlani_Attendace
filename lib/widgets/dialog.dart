import '../utils/import.dart';

Future<void> showConfirmationDialog({
  required String actionType,
  required String message,
  required VoidCallback onConfirm,
}) async {
  showDialog(
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
        title: Text(actionType),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              Get.back();
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );
}
