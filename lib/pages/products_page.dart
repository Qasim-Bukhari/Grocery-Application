import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/cart.dart';
import 'cart_page.dart';
import '../widgets/product_card.dart';

class ProductsPage extends StatelessWidget {
  final List<Product> products = [
    Product(title: 'Apple', imageUrl: 'assets/images/apple.png', price: 1.5),
    Product(title: 'Banana', imageUrl: 'assets/images/banana.png', price: 1.2),
    Product(title: 'Orange', imageUrl: 'assets/images/orange.png', price: 1.0),
    Product(title: 'Strawberry', imageUrl: 'assets/images/strawberry.png', price: 2.0),
    Product(title: 'Grapes', imageUrl: 'assets/images/grapes.png', price: 3.0),
    Product(title: 'Pineapple', imageUrl: 'assets/images/pineapple.png', price: 1.8),
    Product(title: 'Carrot', imageUrl: 'assets/images/carrot.png', price: 0.5),
    Product(title: 'Broccoli', imageUrl: 'assets/images/broccoli.png', price: 1.3),
    Product(title: 'Tomato', imageUrl: 'assets/images/tomato.png', price: 0.8),
    Product(title: 'Potato', imageUrl: 'assets/images/potato.png', price: 0.6),
    Product(title: 'Lettuce', imageUrl: 'assets/images/lettuce.png', price: 1.0),
    Product(title: 'Onion', imageUrl: 'assets/images/onion.png', price: 0.4),
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            int columns = 2; // Default to 2 columns

            // Adjust columns based on screen width
            if (constraints.maxWidth > 1200) {
              columns = 4; // More columns for larger screens
            } else if (constraints.maxWidth > 800) {
              columns = 3; // Medium screens get 3 columns
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                childAspectRatio: 0.75, // Adjusted for aesthetic appeal
                crossAxisSpacing: 25, // Increased horizontal spacing
                mainAxisSpacing: 25,  // Increased vertical spacing
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Container(
                  constraints: BoxConstraints(
                    maxWidth: 200, // Set a maximum width for cards
                    maxHeight: 300, // Set a maximum height for cards
                  ),
                  child: ProductCard(
                    product: products[index],
                    onAddToCart: () {
                      Provider.of<Cart>(context, listen: false).add(products[index]);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${products[index].title} added to cart!')),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      )
    );
  }
}
