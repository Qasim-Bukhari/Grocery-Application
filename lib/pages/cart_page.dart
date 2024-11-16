import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.green,
        elevation: 4, // Slight shadow for the app bar
      ),
      backgroundColor: Colors.white, // Background color of the page
      body: cart.items.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600], // Slightly darker grey
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return Card( // Using Card for better elevation effect
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        elevation: 2, // Shadow for the card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // Rounded corners
                        ),
                        child: ListTile(
                          title: Text(item.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          subtitle: Text('Price: \$${item.price.toStringAsFixed(2)}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, color: Colors.red),
                                onPressed: () {
                                  if (item.quantity > 1) {
                                    cart.updateQuantity(item, item.quantity - 1);
                                  }
                                },
                              ),
                              Text('${item.quantity}', style: TextStyle(fontSize: 16)),
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.green),
                                onPressed: () {
                                  cart.updateQuantity(item, item.quantity + 1);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: \$${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showCheckoutDialog(context, cart);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.green, // Text color
                          elevation: 5, // Shadow effect
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Rounded corners
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25), // Padding
                          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Text style
                        ),
                        child: Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void _showCheckoutDialog(BuildContext context, Cart cart) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Total: \$${cart.totalAmount.toStringAsFixed(2)}. Confirm order?'),
          actions: [
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm', style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.of(context).pop();
                cart.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Order confirmed!')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
