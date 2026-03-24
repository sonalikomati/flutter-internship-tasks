import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Todo App',
      theme: ThemeData(
        // Set up the overall theme of the app
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner:
          false, // Removes the debug banner on the top right
      home: const HomeScreen(), // Launches the home screen
    );
  }
}
