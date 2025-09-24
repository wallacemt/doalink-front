import 'package:doalink/screens/app/user_donation_box.dart';
import 'package:doalink/screens/app/user_settings.dart';
import 'package:doalink/theme/app_colors.dart';
import 'package:doalink/widgets/maps/map.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class WrapHomeScreen extends StatelessWidget {
  final String route;
  const WrapHomeScreen({super.key, required this.route});

  static List<Map<String, dynamic>> pages = [
    {"path": "/home", "widget": const UserDonationBox()},
    {"path": "/map", "widget": const MapScreen()},
    {"path": "/profile", "widget": const UserSettings()},
  ];

  int _getCurrentIndex() {
    for (int i = 0; i < pages.length; i++) {
      if (pages[i]["path"] == route) {
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = _getCurrentIndex();

    return Scaffold(
      backgroundColor: AppColors.cleanCian,
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: AppColors.cleanCian,
          color: AppColors.orange_500,
          buttonBackgroundColor: AppColors.orange_600,
          animationDuration: const Duration(milliseconds: 300),
          index: currentIndex,
          height: 60,
          onTap: (index) {
            Navigator.of(context).pushNamed(pages[index]["path"]);
          },
          items: const [
            Icon(
              Icons.home_outlined, color: AppColors.cleanCian,
            ),
            Icon(Icons.map_rounded, color: AppColors.cleanCian,),
            Icon(Icons.person_2_outlined, color: AppColors.cleanCian,)
          ]),
      body: pages[currentIndex]["widget"] as Widget,
    );
  }
}
