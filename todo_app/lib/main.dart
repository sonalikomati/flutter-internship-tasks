import 'package:flutter/material.dart';
import 'screens/todo_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter To-Do App',
      debugShowCheckedModeBanner: false, // Removes the debug banner
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const TodoListScreen(), // Points to our custom screen
    );
  }
}
