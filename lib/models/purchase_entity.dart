class PurchaseEntity {
  final String productName;
  final int quantity;
  final double price;
  final int productId;

  PurchaseEntity({
    required this.productName,
    required this.quantity,
    required this.price,
    required this.productId,
  });

  @override
  String toString() {
    return 'Product id: $productId, name: $productName, price: $price, quanity: $quantity';
  }
}
