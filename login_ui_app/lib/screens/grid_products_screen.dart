import 'package:flutter/material.dart';
import 'package:login_ui_app/models/grid_product.dart';

class GridProductsScreen extends StatelessWidget {
  GridProductsScreen({super.key});

  // 1. Create a list of at least 6 products using Icons
  final List<GridProduct> products = [
    GridProduct(name: "Laptop Pro", price: "\$1,299", icon: Icons.laptop_mac),
    GridProduct(name: "Smartphone", price: "\$899", icon: Icons.phone_android),
    GridProduct(
      name: "Wireless Earbuds",
      price: "\$149",
      icon: Icons.headphones,
    ),
    GridProduct(name: "Smart Watch", price: "\$249", icon: Icons.watch),
    GridProduct(
      name: "4K Monitor",
      price: "\$399",
      icon: Icons.desktop_windows,
    ),
    GridProduct(
      name: "Mechanical Keyboard",
      price: "\$129",
      icon: Icons.keyboard,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Products Grid"),
        backgroundColor: const Color(0xFF6A11CB),
        centerTitle: true,
      ),
      // 2. Build the GridView
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: products.length,
          // Defines how many columns we want (2 in this case)
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85, // Adjusts height vs width of the grid items
          ),
          itemBuilder: (context, index) {
            final product = products[index];

            // 3. Design each Grid Item
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                // 4. Tap action -> Show SnackBar
                onTap: () {
                  ScaffoldMessenger.of(
                    context,
                  ).clearSnackBars(); // Clear previous
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${product.name} clicked!"),
                      backgroundColor: const Color(0xFF6A11CB),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Product Icon
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: const Color(0xFF6A11CB).withOpacity(0.1),
                      child: Icon(
                        product.icon,
                        size: 40,
                        color: const Color(0xFF6A11CB),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Product Name
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),

                    // Product Price
                    Text(
                      product.price,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green, // Differentiate price color
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
