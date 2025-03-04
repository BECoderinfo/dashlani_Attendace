import '../utils/import.dart';

class CustomDialog {
  Future<bool> showExitDialog(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Exit App',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: 16.rAll,
          ),
          child: Padding(
            padding: 16.pAll,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.exit_to_app,
                  size: 50,
                  color: Colors.red,
                ),
                16.vs,
                Text(
                  'Exit App?',
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                8.vs,
                Text(
                  'Are you sure you want to exit the app?',
                  style: context.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                16.vs,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: const Text('Exit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );
        return ScaleTransition(
          scale: curvedAnimation,
          child: child,
        );
      },
    ).then((value) => false);
  }

  showCustomDialog(
    BuildContext context, {
    required String title,
    required String message,
    required Widget deleteButton,
    Widget? discountField,
  }) {
    return showGeneralDialog(
      context: context,
      barrierLabel: title,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: 16.rAll,
          ),
          child: Padding(
            padding: 16.pAll,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                8.vs,
                Text(
                  title,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                8.vs,
                Text(
                  message,
                  style: context.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                8.vs,
                discountField ?? Container(),
                16.vs,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Cancel'),
                    ),
                    10.hs,
                    deleteButton,
                  ],
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );
        return ScaleTransition(
          scale: curvedAnimation,
          child: child,
        );
      },
    ).then((value) => false);
  }

  selectLevelDialog(
    BuildContext context, {
    required String title,
    required Widget row,
  }) {
    return showGeneralDialog(
      context: context,
      barrierLabel: title,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: 16.rAll,
          ),
          child: Padding(
            padding: 16.pAll,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                8.vs,
                Text(
                  title,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                8.vs,
                row,
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );
        return ScaleTransition(
          scale: curvedAnimation,
          child: child,
        );
      },
    ).then((value) => false);
  }
}
