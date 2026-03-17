import 'package:flutter/material.dart';
import '../main.dart'; // Import main.dart to access the AppDrawer widget

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      // Attach the reusable drawer
      drawer: const AppDrawer(),

      // Center text as required
      body: const Center(
        child: Text(
          'Home Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
