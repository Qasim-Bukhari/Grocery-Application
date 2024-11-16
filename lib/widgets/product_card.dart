import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final product;
  final VoidCallback onAddToCart;

  ProductCard({required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image container
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Container(
                color: Colors.grey[200], // Background color under the image
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          // Product details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14, // Reduced font size
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Price: \$${product.price}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]), // Smaller text color
                ),
              ],
            ),
          ),
          // Add to Cart button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: onAddToCart,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 8),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: TextStyle(fontSize: 12),
              ),
              child: Text(
                'Add to Cart',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 8), // Add some space at the bottom
        ],
      ),
    );
  }
}
