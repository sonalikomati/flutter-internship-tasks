import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const LocalStorageApp());
}

class LocalStorageApp extends StatelessWidget {
  const LocalStorageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shared Prefs Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UserInputScreen(),
    );
  }
}

class UserInputScreen extends StatefulWidget {
  const UserInputScreen({super.key});

  @override
  State<UserInputScreen> createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  // 1️⃣ Controller for the TextField
  final TextEditingController _textController = TextEditingController();

  String _savedText = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadSavedData(); // Load data automatically when the app starts
  }

  // 2️⃣ Function to LOAD data with Error Handling
  Future<void> _loadSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        // Retrieve the string, or use a default message if it doesn't exist
        _savedText = prefs.getString('user_note') ?? "No data saved yet.";
      });
    } catch (e) {
      // ⚠️ Error Handling: If storage fails to load
      setState(() {
        _savedText = "Error loading data.";
      });
      _showSnackBar("Failed to load data: $e", isError: true);
    }
  }

  // 3️⃣ Function to SAVE data with Error Handling
  Future<void> _saveData() async {
    final inputText = _textController.text.trim();

    // ⚠️ Error Handling: Prevent saving empty data
    if (inputText.isEmpty) {
      _showSnackBar("Please enter some text before saving!", isError: true);
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();

      // setString returns a boolean indicating if the save was successful
      final isSaved = await prefs.setString('user_note', inputText);

      if (isSaved) {
        setState(() {
          _savedText = inputText;
        });
        _textController.clear(); // Clear the text field after saving
        _showSnackBar("Data saved successfully locally! 💾");
      } else {
        // ⚠️ Error Handling: If the device rejected the save
        _showSnackBar("Failed to save data to device.", isError: true);
      }
    } catch (e) {
      // ⚠️ Error Handling: Catching unexpected storage crashes
      _showSnackBar("An unexpected error occurred: $e", isError: true);
    }
  }

  // Helper function to show notifications to the user
  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose(); // Prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Local Storage App"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display Area
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: Column(
                children: [
                  const Text(
                    "Currently Saved Data:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _savedText,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Input Area
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: "Enter a note or your name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 20),

            // Save Button
            ElevatedButton.icon(
              onPressed: _saveData,
              icon: const Icon(Icons.save),
              label: const Text("Save Locally"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
