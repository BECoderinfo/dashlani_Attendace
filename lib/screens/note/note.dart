import '../../utils/import.dart';

class Note extends GetView<NoteController> {
  const Note({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: NoteController(ctx: context),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Note'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                children: [
                  Obx(
                    () => TextFormField(
                      controller: controller.noteController,
                      decoration: InputDecoration(
                        labelText: 'Note',
                        hintText: 'Enter Note',
                        errorText: controller.noteError.isEmpty
                            ? null
                            : controller.noteError.value,
                      ),
                      maxLines: 2,
                      onChanged: (value) {
                        if (controller.noteController.text.isNotEmpty) {
                          controller.checkValidation();
                        }
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const Gap(16),
                  // Obx(
                  //   () => SizedBox(
                  //     width: double.infinity,
                  //     child: ElevatedButton(
                  //       onPressed: () {},
                  //       child: const Text('Pick File'),
                  //     ),
                  //   ),
                  // ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Pick File'),
                  ),
                  const Gap(16),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: controller.sendNote,
                          icon: (controller.isSending.value)
                              ? null
                              : const Icon(Icons.send),
                          label: (controller.isSending.value)
                              ? const CircularProgressIndicator()
                              : const Text('send'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
