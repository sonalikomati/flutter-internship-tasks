import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// We use a StatefulWidget for the main app so we can update the theme dynamically
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Set the default theme to Light Mode
  ThemeMode _themeMode = ThemeMode.light;

  // Function to toggle between Light and Dark mode
  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dark/Light Mode App',

      // 1. Define the Light Theme
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),

      // 2. Define the Dark Theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[850],
          foregroundColor: Colors.white,
        ),
      ),

      // 3. Set the current Theme Mode based on our variable
      themeMode: _themeMode,

      // Pass the current state and the toggle function to the Home Screen
      home: HomeScreen(
        isDarkMode: _themeMode == ThemeMode.dark,
        onThemeChanged: toggleTheme,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme Toggle App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display an icon based on the current mode
            Icon(
              isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
              size: 100,
              color: isDarkMode ? Colors.yellow : Colors.orange,
            ),
            const SizedBox(height: 20),

            // Display text based on the current mode
            Text(
              isDarkMode ? 'Dark Mode is ON' : 'Light Mode is ON',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            // The Switch to toggle modes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Light', style: TextStyle(fontSize: 18)),
                Switch(
                  value: isDarkMode,
                  onChanged: onThemeChanged,
                  activeColor: Colors.deepPurpleAccent,
                ),
                const Text('Dark', style: TextStyle(fontSize: 18)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
