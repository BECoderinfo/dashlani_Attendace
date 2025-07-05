import 'package:cached_network_image/cached_network_image.dart';
import '../../utils/import.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: const Text(
          "DT Chats",
          style: TextStyle(color: AppColors.blackColor),
        ),
        automaticallyImplyLeading: false,
        // This removes the default leading space
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Back",
              style: TextStyle(color: AppColors.blackColor),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(10),
              const SizedBox(
                height: 90,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 10,
                    children: [
                      EmpCard(),
                      EmpCard(),
                      EmpCard(),
                      EmpCard(),
                      EmpCard(),
                    ],
                  ),
                ),
              ),
              const Gap(10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Chats", style: TextStyle(fontSize: 18)),
                  Icon(
                    Icons.more_horiz,
                    color: AppColors.blackColor,
                  ),
                ],
              ),
              const Gap(10),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return chatTile();
                },
                separatorBuilder: (context, index) => const Gap(14),
                itemCount: 10,
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}

Widget chatTile() {
  return InkWell(
    onTap: () {
      Get.toNamed(Routes.chat);
    },
    child: Row(
      children: [
        const CircleAvatar(
          radius: 26,
          backgroundImage: CachedNetworkImageProvider(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSg5rJ9bo6bWmO5V55oahnFe3fH8B38cp6guQ&s',
          ),
        ),
        const Gap(10),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "DT Support",
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(4),
            Text(
              "Hi! How can I help you?",
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        const Spacer(),
        const Gap(4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              "12:00",
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
            const Gap(4),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  "2",
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class EmpCard extends StatelessWidget {
  const EmpCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 70,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: CachedNetworkImageProvider(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSg5rJ9bo6bWmO5V55oahnFe3fH8B38cp6guQ&s',
            ),
          ),
          Gap(4),
          Text(
            "DT Support",
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
