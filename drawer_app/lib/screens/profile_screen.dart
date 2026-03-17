import 'package:flutter/material.dart';
import '../main.dart'; // Import main.dart to access the AppDrawer widget

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      // Attach the reusable drawer
      drawer: const AppDrawer(),

      // Center text as required
      body: const Center(
        child: Text(
          'Profile Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
