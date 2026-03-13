import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'profile_screen.dart';
import '../widgets/bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  final List<String> titles = ["Home", "Search", "Profile"];

  void changeTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titles[currentIndex]), centerTitle: true),

      body: screens[currentIndex],

      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: changeTab,
      ),
    );
  }
}
