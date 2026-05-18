import 'package:shop/models/product.dart';
import 'package:shop/models/product_filter_state.dart';

class ProductFilterLogic {
  ProductFilterLogic._();

  static PriceRange catalogRange(List<Product> all) {
    if (all.isEmpty) return const PriceRange(min: 0, max: 300);
    final prices = all.map((p) => p.price);
    return PriceRange(min: prices.reduce((a, b) => a < b ? a : b), max: prices.reduce((a, b) => a > b ? a : b));
  }

  static List<Product> apply(List<Product> all, ProductFilterState state) {
    var result = all.where((p) {
      if (state.gender != null && p.gender != state.gender) return false;
      if (state.category != null && p.productCategory != state.category) {
        return false;
      }
      if (state.minPrice != null && p.price < state.minPrice!) return false;
      if (state.maxPrice != null && p.price > state.maxPrice!) return false;
      if (state.search.isNotEmpty &&
          !p.name.toLowerCase().contains(state.search.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();

    switch (state.sort) {
      case ProductSort.featured:
        break;
      case ProductSort.priceAsc:
        result.sort((a, b) => a.price.compareTo(b.price));
      case ProductSort.priceDesc:
        result.sort((a, b) => b.price.compareTo(a.price));
      case ProductSort.rating:
        result.sort((a, b) => b.rating.compareTo(a.rating));
      case ProductSort.name:
        result.sort((a, b) => a.name.compareTo(b.name));
    }

    return result;
  }
}
