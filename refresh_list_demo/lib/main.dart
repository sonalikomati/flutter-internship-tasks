import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const RefreshableListScreen(),
    );
  }
}

class RefreshableListScreen extends StatefulWidget {
  const RefreshableListScreen({super.key});

  @override
  State<RefreshableListScreen> createState() => _RefreshableListScreenState();
}

class _RefreshableListScreenState extends State<RefreshableListScreen> {
  // 1. Initialize the list with 25 items
  List<String> _items = List.generate(
    25,
    (index) => "Original Card ${index + 1}",
  );

  // 2. The simulated API call function
  Future<void> _handleRefresh() async {
    // Simulate a 2-second network delay
    await Future.delayed(const Duration(seconds: 2));

    // 3. Update the UI with new items
    setState(() {
      _items = List.generate(
        25,
        (index) => "Refreshed Card ${index + 1} (Updated)",
      );
    });

    // Optional: Show a snackbar when done
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("List updated successfully!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pull to Refresh List"),
        centerTitle: true,
        elevation: 2,
      ),
      // 4. The RefreshIndicator handles the pull-down gesture
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: Colors.white,
        backgroundColor: Colors.blue,
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: _items.length,
          // Use AlwaysScrollableScrollPhysics to ensure pull-to-refresh
          // works even if the list is too short to scroll.
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            // 5. Build the Card item
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Text("${index + 1}"),
                ),
                title: Text(
                  _items[index],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text("Pull down to trigger simulated API"),
                trailing: const Icon(Icons.refresh, color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }
}
