import 'package:get/get.dart';

class CounterController extends GetxController {
  // Observable state
  var count = 0.obs;

  // Business logic for incrementing
  void increment() {
    count++;
  }

  // Business logic for decrementing
  void decrement() {
    count--;
  }
}
