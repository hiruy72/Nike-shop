import 'package:shop/models/product.dart';

class CartLine {
  CartLine({
    required this.product,
    required this.size,
    required this.region,
    this.quantity = 1,
    String? id,
  }) : id = id ?? '${product.id}_${size}_${region.name}';

  final String id;
  final Product product;
  final String size;
  final SizeRegion region;
  int quantity;

  double get lineTotal => product.price * quantity;
}
