import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drawer Navigation App',
      theme: ThemeData(primarySwatch: Colors.blue),
      // 1. Initial route when the app starts
      initialRoute: '/home',

      // 2. Define our named routes for smooth navigation
      routes: {
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}

/// Reusable Drawer Widget
/// We define it in main.dart to handle the Drawer setup and Navigation logic centrally
class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  // Custom function to handle navigation smoothly
  void _navigateTo(BuildContext context, String routeName) {
    // 1. Automatically close the drawer FIRST
    Navigator.pop(context);

    // 2. Check the current route so we don't reload the same screen if clicked twice
    final String? currentRoute = ModalRoute.of(context)?.settings.name;

    if (currentRoute != routeName) {
      // 3. Use pushReplacementNamed to replace the current screen
      // This behaves like bottom navigation by not stacking screens infinitely
      Navigator.pushReplacementNamed(context, routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, // Removes default padding at the top
        children: [
          // Drawer Header with user info and avatar
          const UserAccountsDrawerHeader(
            accountName: Text('SONALI'),
            accountEmail: Text('sonali@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.redAccent),
            ),
            decoration: BoxDecoration(color: Colors.redAccent),
          ),

          // Menu Items
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => _navigateTo(context, '/home'),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => _navigateTo(context, '/profile'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => _navigateTo(context, '/settings'),
          ),
        ],
      ),
    );
  }
}
