class Product {
  final String title;
  final String imageUrl;
  int quantity;
  final double price;

  Product({
    required this.title,
    required this.imageUrl,
    this.quantity = 1,
    required this.price,
  });
}
