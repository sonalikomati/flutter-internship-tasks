import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search here...",
              prefixIcon: const Icon(Icons.search),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),

              filled: true,
              fillColor: Colors.grey.shade200,
            ),
          ),
        ],
      ),
    );
  }
}
