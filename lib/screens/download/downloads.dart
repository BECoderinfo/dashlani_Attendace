import '../../utils/import.dart';

class Downloads extends GetView<DownloadController> {
  const Downloads({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DownloadController>(
      init: DownloadController(ctx: context),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Downloads'),
            actions: [
              Obx(
                () => (controller.isLoading.value == true)
                    ? const Image(image: AssetImage('assets/images/loding.gif'))
                    : IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {
                          controller.getDownloads();
                        },
                      ),
              )
            ],
          ),
          body: Obx(
            () => controller.downloads.isEmpty
                ? Center(
                    child: Text(
                      'No downloads available.',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  )
                : ListView.builder(
                    itemCount: controller.downloads.length,
                    itemBuilder: (context, index) {
                      var document = controller.downloads[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: const Icon(Icons.description, size: 40),
                          title: Text(document.documentName!),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Sent On: ${document.createdAt!}'),
                              const Text('Sent By: Admin'),
                            ],
                          ),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'Preview') {
                                controller.previewDocument(document);
                              } else if (value == 'Download') {
                                controller.downloadDocument(document);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'Preview',
                                child: Text('Preview'),
                              ),
                              const PopupMenuItem(
                                value: 'Download',
                                child: Text('Download'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
