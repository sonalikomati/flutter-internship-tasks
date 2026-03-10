import 'package:flutter/material.dart';
import 'package:login_ui_app/models/product.dart';
import 'package:login_ui_app/screens/product_details_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  // Dummy Data
  final List<Product> products = [
    Product(
      name: "Wireless Headphones",
      price: "\$99.99",
      description:
          "High-quality noise-canceling wireless headphones with 20h battery life.",
      imageUrl:
          "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&auto=format&fit=crop&q=60",
    ),
    Product(
      name: "Smart Watch",
      price: "\$149.50",
      description:
          "Track your fitness and notifications with this sleek smart watch.",
      imageUrl:
          "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&auto=format&fit=crop&q=60",
    ),
    Product(
      name: "Running Shoes",
      price: "\$85.00",
      description: "Lightweight running shoes designed for speed and comfort.",
      imageUrl:
          "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&auto=format&fit=crop&q=60",
    ),
    Product(
      name: "Leather Backpack",
      price: "\$120.00",
      description:
          "Premium leather backpack, perfect for laptops and daily commute.",
      imageUrl:
          "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500&auto=format&fit=crop&q=60",
    ),
  ];

  // Map to keep track of quantity for each product index
  // Key = Product Index, Value = Quantity
  final Map<int, int> _cartQuantities = {};

  void _incrementQuantity(int index) {
    setState(() {
      int currentQty = _cartQuantities[index] ?? 0;
      _cartQuantities[index] = currentQty + 1;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      int currentQty = _cartQuantities[index] ?? 0;
      if (currentQty > 0) {
        _cartQuantities[index] = currentQty - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Our Products"),
        backgroundColor: const Color(0xFF6A11CB),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            final quantity =
                _cartQuantities[index] ?? 0; // Get qty or default to 0

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  // Navigate to Details Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailsScreen(product: product),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(
                    8.0,
                  ), // Added padding around internal content
                  child: Row(
                    children: [
                      // 1. Product Image
                      Hero(
                        tag: product.name,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            product.imageUrl,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // 2. Product Details (Name, Price)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              product.price,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xFF6A11CB),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              product.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 3. Simple Quantity Controls
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Decrement
                            GestureDetector(
                              onTap: quantity > 0
                                  ? () => _decrementQuantity(index)
                                  : null,
                              child: Icon(
                                Icons.remove,
                                size: 18,
                                color: quantity > 0
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),

                            const SizedBox(width: 8),

                            // Quantity Text
                            Text(
                              quantity.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const SizedBox(width: 8),

                            // Increment
                            GestureDetector(
                              onTap: () => _incrementQuantity(index),
                              child: const Icon(
                                Icons.add,
                                size: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
