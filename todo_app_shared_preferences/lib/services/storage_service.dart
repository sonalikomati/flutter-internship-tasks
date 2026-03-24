import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // Define a constant key to access our data
  static const String _tasksKey = 'todo_tasks';

  // Save the list of tasks to SharedPreferences
  Future<void> saveTasks(List<String> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    // SharedPreferences allows us to store lists of Strings easily
    await prefs.setStringList(_tasksKey, tasks);
  }

  // Load the list of tasks from SharedPreferences
  Future<List<String>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    // Return the saved list, or an empty list if nothing is saved yet
    return prefs.getStringList(_tasksKey) ?? [];
  }
}
