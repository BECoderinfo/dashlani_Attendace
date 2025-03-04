import 'package:attendance_app/controllers/profile/my_profile_controller.dart';
import 'package:attendance_app/modals/employee/employee_modal.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/import.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    User user = Get.arguments;
    MyProfileController controller = Get.put(MyProfileController());
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 50, left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.back),
                  onTap: () {
                    Get.back();
                  },
                ),
                const Text(
                  'My Profile',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.blackColor),
                ),
                const Gap(10),
              ],
            ),
          ),
          const Gap(26),
          // Tabs
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            decoration: BoxDecoration(
                color: AppColors.bgColor,
                borderRadius: BorderRadius.circular(8)),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Obx(
              () => Row(
                children: [
                  _TabButton(
                    text: 'Personal',
                    isActive: (controller.currentTab.value == 0) ? true : false,
                    onTap: () {
                      if (controller.currentTab.value != 0) {
                        controller.changeTab(index: 0);
                      }
                    },
                  ),
                  _TabButton(
                    text: 'Professional',
                    isActive: (controller.currentTab.value == 1) ? true : false,
                    onTap: () {
                      if (controller.currentTab.value != 1) {
                        controller.changeTab(index: 1);
                      }
                    },
                  ),
                  _TabButton(
                    text: 'Documents',
                    isActive: (controller.currentTab.value == 2) ? true : false,
                    onTap: () {
                      if (controller.currentTab.value != 2) {
                        controller.changeTab(index: 2);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          // Personal Information
          Obx(
            () {
              return Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  transitionBuilder: (widget, animation) {
                    return SlideTransition(
                      // opacity: animation,
                      position: animation.drive(
                          Tween(begin: const Offset(1, 0), end: Offset.zero)),
                      child: widget,
                    );
                  },
                  child: IndexedStack(
                    key: ValueKey<int>(controller.currentTab.value),
                    index: controller.currentTab.value,
                    children: [
                      personalInfo(user),
                      professionalInfo(user),
                      documentInfo(user, context: context),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

personalInfo(User user) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _ProfileField(label: 'Full Name', value: user.name),
      _ProfileField(label: 'Email Address', value: user.email),
      _ProfileField(label: 'Phone Number', value: user.phone ?? '-'),
      _ProfileField(label: 'Address', value: user.address ?? '-'),
    ],
  );
}

professionalInfo(User user) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _ProfileField(label: 'Employee ID', value: user.empId ?? '-'),
      _ProfileField(label: 'Designation', value: user.role ?? '-'),
      _ProfileField(label: 'Company email Address', value: user.email ?? '-'),
      _ProfileField(label: 'Employee Type', value: user.epmType ?? '-'),
      _ProfileField(label: 'Department', value: user.departments ?? '-'),
      const _ProfileField(label: 'Company Experience', value: '-'),
      const _ProfileField(label: 'Office Time', value: '9:00 am to 6:00 pm'),
    ],
  );
}

documentInfo(User user, {required BuildContext context}) {
  return (user.documents.isEmpty)
      ? const Center(child: Text('No Documents'))
      : ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          itemCount: user.documents.length,
          itemBuilder: (context, index) {
            Document document = user.documents[index];
            return _DocumentField(
              context: context,
              label: document.documentName,
              url: '${Apis.serverAddress}/${document.documentPath}',
              documentId: document.id,
            );
          },
        );
}

class _TabButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback? onTap;

  const _TabButton(
      {required this.text, this.isActive = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isActive ? AppColors.iconColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 2),
        const Divider(
          color: AppColors.bgColor,
        ),
      ],
    );
  }
}

class _DocumentField extends StatelessWidget {
  final String label;
  final String url;
  final BuildContext context;
  final String documentId;

  const _DocumentField({
    required this.label,
    required this.url,
    required this.context,
    required this.documentId,
  });

  @override
  Widget build(BuildContext context) {
    MyProfileController controller = Get.find<MyProfileController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          onTap: () {
            controller.previewDocument(uri: url);
          },
          leading: const CircleAvatar(
            backgroundColor: AppColors.bgColor,
            child: Icon(CupertinoIcons.doc_append, color: AppColors.blackColor),
          ),
          title: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          trailing: InkWell(
            onTap: () {
              controller.downloadDocument(uri: url, name: label);
            },
            child: const Icon(
              CupertinoIcons.cloud_download,
              color: AppColors.blackColor,
            ),
          ),
        ),
        const SizedBox(height: 2),
        const Divider(
          color: AppColors.bgColor,
        ),
      ],
    );
  }
}
