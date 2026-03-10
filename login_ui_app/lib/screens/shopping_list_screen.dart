import 'package:flutter/material.dart';
import 'package:login_ui_app/models/shopping_item.dart';
import 'package:login_ui_app/screens/cart_screen.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final TextEditingController _textController = TextEditingController();

  final List<ShoppingItem> _items = [];

  void _addItem(String name) {
    if (name.trim().isNotEmpty) {
      setState(() {
        _items.add(ShoppingItem(name: name.trim()));
      });
      _textController.clear();
    }
  }

  void _incrementQuantity(int index) {
    setState(() {
      _items[index].quantity++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(items: _items),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: "Enter product name",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) => _addItem(value),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];

                return ListTile(
                  title: Text(item.name),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => _decrementQuantity(index),
                      ),

                      Text("${item.quantity}"),

                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _incrementQuantity(index),
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _removeItem(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
