import 'package:attendance_app/screens/holidays/holiday_list.dart';
import 'package:attendance_app/screens/leave/leaves.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:animations/animations.dart'; // Add this to pubspec.yaml

import '../../utils/import.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final bottomNavController = Get.put(BottomNavController());

    // Pages to display based on selected index
    final List<Widget> pages = [
      const HomeScreen(),
      const Leaves(),
      const HolidayList(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: Obx(
        () {
          // Wrap the body with PageTransitionSwitcher for animations
          return PageTransitionSwitcher(
            duration: const Duration(milliseconds: 1000),
            transitionBuilder: (child, animation, secondaryAnimation) {
              log('Switching to: ${child.runtimeType}');
              return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
              );
            },
            child: pages[bottomNavController.selectedIndex.value],
          );
        },
      ),
      bottomNavigationBar: Obx(
        () {
          return StylishBottomBar(
            currentIndex: bottomNavController.selectedIndex.value,
            onTap: (index) {
              bottomNavController.changeIndex(index); // Change selected index
            },
            items: [
              BottomBarItem(
                icon: const Icon(
                  Icons.house_outlined,
                ),
                selectedIcon: const Icon(Icons.house_rounded),
                selectedColor: AppColors.secondaryColor,
                unSelectedColor: AppColors.greyColor,
                title: const Text('Home'),
              ),
              BottomBarItem(
                icon: const Icon(
                  Icons.calendar_month_outlined,
                ),
                selectedIcon: const Icon(
                  Icons.calendar_month,
                ),
                selectedColor: AppColors.secondaryColor,
                unSelectedColor: AppColors.greyColor,
                title: const Text('Leaves'),
              ),
              BottomBarItem(
                icon: const Icon(
                  Icons.holiday_village_outlined,
                ),
                selectedIcon: const Icon(
                  Icons.holiday_village,
                ),
                selectedColor: AppColors.secondaryColor,
                unSelectedColor: AppColors.greyColor,
                title: const Text('Holiday'),
              ),
              BottomBarItem(
                icon: const Icon(
                  Icons.person_outline,
                ),
                selectedIcon: const Icon(
                  Icons.person,
                ),
                selectedColor: AppColors.secondaryColor,
                unSelectedColor: AppColors.greyColor,
                title: const Text('Profile'),
              ),
            ],
            option: DotBarOptions(
              dotStyle: DotStyle.tile,
              gradient: const LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.iconColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          );
        },
      ),
    );
  }
}
