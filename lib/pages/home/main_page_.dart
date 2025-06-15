import 'package:beasiswa/pages/home/home_page.dart';
import 'package:beasiswa/pages/home/profile_page.dart';
import 'package:beasiswa/pages/home/daftar_beasiswa_page.dart';
import 'package:beasiswa/theme.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  Widget customBottomNav() {
    final BorderRadius borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.3 * 255).toInt()),
            blurRadius: 15,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          elevation: 0,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/home.png',
                width: 21,
                color: currentIndex == 0 ? primaryColor : Colors.grey,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/bookmark.png',
                width: 21,
                color: currentIndex == 1 ? primaryColor : Colors.grey,
              ),
              label: 'Beasiswa',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/profile.png',
                width: 21,
                color: currentIndex == 2 ? primaryColor : Colors.grey,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget pages() {
    switch (currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return BeasiswaListPage();
      case 2:
        return ProfilePage();
      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: customBottomNav(),
      body: pages(),
    );
  }
}
