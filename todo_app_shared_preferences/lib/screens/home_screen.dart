import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller to read the text typed into the TextField
  final TextEditingController _taskController = TextEditingController();

  // Instance of our custom StorageService
  final StorageService _storageService = StorageService();

  // State variable to hold our list of tasks
  List<String> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  // Fetches tasks from local storage and updates the UI
  Future<void> _loadTasks() async {
    final loadedTasks = await _storageService.loadTasks();
    setState(() {
      _tasks = loadedTasks;
    });
  }

  // Adds a new task to the list and saves it
  void _addTask() {
    final String newTask = _taskController.text.trim();
    if (newTask.isEmpty) return; // Don't add empty tasks

    setState(() {
      _tasks.add(newTask); // Add to local list
      _taskController.clear(); // Clear the text field
    });

    // Save updated list to storage
    _storageService.saveTasks(_tasks);
  }

  // Updates an existing task and saves it
  void _updateTask(int index, String updatedTask) {
    final String trimmedTask = updatedTask.trim();
    if (trimmedTask.isEmpty) return; // Don't save empty updates

    setState(() {
      _tasks[index] = trimmedTask; // Update the specific index
    });

    // Save updated list to storage
    _storageService.saveTasks(_tasks);
  }

  // Deletes a task by its index and updates storage
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index); // Remove from local list
    });

    // Save updated list to storage
    _storageService.saveTasks(_tasks);
  }

  // Shows a dialog to edit the selected task
  Future<void> _showEditDialog(int index) async {
    // Create a new controller pre-filled with the current task text
    final TextEditingController editController = TextEditingController(
      text: _tasks[index],
    );

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: editController,
            autofocus: true, // Automatically opens the keyboard
            decoration: const InputDecoration(
              labelText: 'Task name',
              border: OutlineInputBorder(),
            ),
            // Allow saving by pressing "Enter" on the keyboard
            onSubmitted: (_) {
              _updateTask(index, editController.text);
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel edit
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _updateTask(index, editController.text);
                Navigator.of(context).pop(); // Close the dialog after saving
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todo App'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Row containing the TextField and Add Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: 'Enter a task...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addTask(),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _addTask,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 24,
                    ),
                  ),
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Expanded allows the ListView to take up the remaining screen space
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(child: Text('No tasks yet. Add one above!'))
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(_tasks[index]),
                            // Wrap icons in a Row so we can show both Edit and Delete
                            trailing: Row(
                              mainAxisSize: MainAxisSize
                                  .min, // Prevents Row from taking infinite width
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blueAccent,
                                  ),
                                  onPressed: () => _showEditDialog(index),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () => _deleteTask(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
