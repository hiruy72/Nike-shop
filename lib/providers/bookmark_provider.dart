import 'package:flutter/foundation.dart';
import 'package:shop/models/product.dart';

class BookmarkProvider extends ChangeNotifier {
  final Set<String> _bookmarkedIds = {};

  bool isBookmarked(String productId) => _bookmarkedIds.contains(productId);

  void toggle(Product product) {
    if (_bookmarkedIds.contains(product.id)) {
      _bookmarkedIds.remove(product.id);
    } else {
      _bookmarkedIds.add(product.id);
    }
    notifyListeners();
  }

  List<String> get bookmarkedIds => _bookmarkedIds.toList();
}
