import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // 1. State Variables
  final List<Task> _tasks = [];
  final TextEditingController _addController = TextEditingController();

  // 2. Add Task Logic with Validation
  void _addTask() {
    final text = _addController.text.trim();
    if (text.isEmpty) {
      // Validation: Show error if empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task title cannot be empty!')),
      );
      return;
    }

    setState(() {
      _tasks.add(
        Task(
          id: DateTime.now().toString(), // Generate unique ID
          title: text,
        ),
      );
    });

    _addController.clear(); // Clear the input field after adding
  }

  // 3. Delete Task Logic
  void _deleteTask(String id) {
    setState(() {
      _tasks.removeWhere((task) => task.id == id);
    });
  }

  // 4. Toggle Completion Logic
  void _toggleCompletion(String id) {
    setState(() {
      final taskIndex = _tasks.indexWhere((task) => task.id == id);
      if (taskIndex != -1) {
        _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
      }
    });
  }

  // 5. Edit Task Dialog Logic
  void _editTaskDialog(Task task) {
    // Prefill the controller with the current title
    TextEditingController editController = TextEditingController(
      text: task.title,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              hintText: 'Enter new task name',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Cancel
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newText = editController.text.trim();
                if (newText.isEmpty) {
                  // Validation for editing
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Task cannot be empty!')),
                  );
                  return;
                }

                // Update UI dynamically
                setState(() {
                  task.title = newText;
                });
                Navigator.pop(context); // Close dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // 6. Build the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My To-Do List'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Inline Input UI for Adding Tasks
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _addController,
                    decoration: const InputDecoration(
                      hintText: 'Add a new task...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addTask(), // Add when pressing 'Enter'
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Add'),
                ),
              ],
            ),
          ),

          // ListView.builder to Display Tasks
          Expanded(
            child: _tasks.isEmpty
                ? const Center(child: Text('No tasks yet. Add one above!'))
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: ListTile(
                          // Checkbox to mark complete
                          leading: Checkbox(
                            value: task.isCompleted,
                            onChanged: (value) => _toggleCompletion(task.id),
                          ),

                          // Task Title with dynamic styling
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: task.isCompleted
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),

                          // Edit and Delete Buttons
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () => _editTaskDialog(task),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _deleteTask(task.id),
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
    );
  }

  // Dispose controllers to prevent memory leaks
  @override
  void dispose() {
    _addController.dispose();
    super.dispose();
  }
}
