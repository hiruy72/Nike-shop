import 'package:flutter/foundation.dart';
import 'package:shop/data/mock_data.dart';
import 'package:shop/models/cart_line.dart';
import 'package:shop/models/product.dart';

class CartProvider extends ChangeNotifier {
  CartProvider() : _lines = List.from(buildInitialCart());

  final List<CartLine> _lines;

  List<CartLine> get lines => List.unmodifiable(_lines);

  int get itemCount => _lines.fold(0, (sum, line) => sum + line.quantity);

  double get subtotal =>
      _lines.fold(0.0, (sum, line) => sum + line.lineTotal);

  void addItem(Product product, String size, SizeRegion region) {
    final existing = _lines.where(
      (l) =>
          l.product.id == product.id &&
          l.size == size &&
          l.region == region,
    );
    if (existing.isNotEmpty) {
      existing.first.quantity++;
    } else {
      _lines.add(
        CartLine(product: product, size: size, region: region),
      );
    }
    notifyListeners();
  }

  void increment(String lineId) {
    final line = _lines.firstWhere((l) => l.id == lineId);
    line.quantity++;
    notifyListeners();
  }

  void decrement(String lineId) {
    final line = _lines.firstWhere((l) => l.id == lineId);
    if (line.quantity > 1) {
      line.quantity--;
      notifyListeners();
    }
  }

  void remove(String lineId) {
    _lines.removeWhere((l) => l.id == lineId);
    notifyListeners();
  }

  void clear() {
    _lines.clear();
    notifyListeners();
  }
}
