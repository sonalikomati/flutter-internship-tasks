import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/counter_controller.dart';

class HomeScreen extends StatelessWidget {
  // Dependency Injection: Controller is initialized here
  final CounterController counterController = Get.put(CounterController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GetX Counter App'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Current Counter Value:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            // Obx listens to changes in the controller's observable variables
            Obx(
              () => Text(
                '${counterController.count}',
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "btn_decrement", // Best practice when using multiple FABs
            onPressed: counterController.decrement,
            backgroundColor: Colors.redAccent,
            child: const Icon(Icons.remove, color: Colors.white),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: "btn_increment",
            onPressed: counterController.increment,
            backgroundColor: Colors.green,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
