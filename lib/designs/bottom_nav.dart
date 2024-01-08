import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:checkmate/pages/attendance_list.dart';
import 'package:checkmate/pages/home.dart';
import 'package:checkmate/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNavBar extends StatefulWidget {
  final int bottomNavIndex;

  const CustomNavBar({super.key, required this.bottomNavIndex});

  @override
  // ignore: no_logic_in_create_state
  State<CustomNavBar> createState() => _CustomNavBarState(bottomNavIndex);
}

class _CustomNavBarState extends State<CustomNavBar> {
  int bottomNavIndex;

  _CustomNavBarState(this.bottomNavIndex);

  final iconList = [
    Icons.home,
    Icons.list,
  ];

  void _onItemTapped(int index) {
    setState(() {
      bottomNavIndex = index;
      if (bottomNavIndex == 0) {
        Get.off(const HomeScreen());
      } else if (bottomNavIndex == 1) {
        Get.off(const StudentInfoPage(
          students: [],
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
      icons: iconList,
      activeIndex: bottomNavIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.verySmoothEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: _onItemTapped,
      backgroundColor: Constants.primaryColor,
      inactiveColor: Constants.secondaryColor,
      activeColor: Constants.tertiaryColor,
      iconSize: 28,
    );
  }
}
