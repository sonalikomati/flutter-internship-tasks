import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // GetMaterialApp handles the routing and theme setup
    return GetMaterialApp(
      title: 'GetX Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Set the initial screen
      home: HomeScreen(),
    );
  }
}
