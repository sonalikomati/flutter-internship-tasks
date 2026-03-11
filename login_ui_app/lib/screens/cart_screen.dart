import 'package:flutter/material.dart';
// Fix the import to match your project structure
import 'package:login_ui_app/models/shopping_item.dart';

class CartScreen extends StatelessWidget {
  final List<ShoppingItem> items;

  const CartScreen({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: const Color(0xFF6A11CB), // Added theme color
      ),
      body: items.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : ListView.separated(
              // Changed to separated for better UI
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (ctx, i) => const Divider(),
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Qty: ${item.quantity}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
