import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/import.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leadingWidth: 40,
        title: const Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: CachedNetworkImageProvider(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSg5rJ9bo6bWmO5V55oahnFe3fH8B38cp6guQ&s',
              ),
            ),
            Gap(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "DT Support",
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(4),
                Text(
                  "Online",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: AppColors.blackColor),
          onPressed: () {
            Get.back();
          },
        ),
        // actions: [],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          const Divider(
            height: 1,
            color: AppColors.iconBg,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(CupertinoIcons.add),
                  color: AppColors.primaryColor,
                  onPressed: () {},
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      hintStyle: TextStyle(
                        color: AppColors.greyColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(CupertinoIcons.mic_fill),
                  color: AppColors.primaryColor,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
