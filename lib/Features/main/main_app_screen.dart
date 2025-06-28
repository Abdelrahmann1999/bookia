import 'package:bookia/Features/Home/presentation/page/home_screen.dart';
import 'package:bookia/Features/wishlist/presintation/page/wishlist_screen.dart';
import 'package:bookia/core/Constants/AppAssete.dart';
import 'package:bookia/core/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    WishlistScreen(),
    const Center(child: Text("Category")),
    const Center(child: Text("Profile")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },

        items: [
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              Appassetes.homeSvg,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            icon: SvgPicture.asset(Appassetes.homeSvg),
            label: "Home",
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              Appassetes.bookmarkSvg,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            icon: SvgPicture.asset(Appassetes.bookmarkSvg),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              Appassetes.categorySvg,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            icon: SvgPicture.asset(Appassetes.categorySvg),
            label: "Category",
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              Appassetes.profileSvg,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            icon: SvgPicture.asset(Appassetes.profileSvg),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
