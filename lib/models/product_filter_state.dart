import 'package:shop/models/product.dart';
import 'package:shop/models/product_category.dart';

enum ProductSort { featured, priceAsc, priceDesc, rating, name }

class ProductFilterState {
  const ProductFilterState({
    this.gender,
    this.category,
    this.sort = ProductSort.featured,
    this.minPrice,
    this.maxPrice,
    this.search = '',
  });

  final ProductGender? gender;
  final ProductCategory? category;
  final ProductSort sort;
  final double? minPrice;
  final double? maxPrice;
  final String search;

  bool get hasActiveFilters =>
      gender != null ||
      category != null ||
      sort != ProductSort.featured ||
      minPrice != null ||
      maxPrice != null;

  int get activeFilterCount {
    var count = 0;
    if (gender != null) count++;
    if (category != null) count++;
    if (sort != ProductSort.featured) count++;
    if (minPrice != null || maxPrice != null) count++;
    return count;
  }

  ProductFilterState copyWith({
    ProductGender? gender,
    bool clearGender = false,
    ProductCategory? category,
    bool clearCategory = false,
    ProductSort? sort,
    double? minPrice,
    double? maxPrice,
    bool clearPrice = false,
    String? search,
  }) {
    return ProductFilterState(
      gender: clearGender ? null : (gender ?? this.gender),
      category: clearCategory ? null : (category ?? this.category),
      sort: sort ?? this.sort,
      minPrice: clearPrice ? null : (minPrice ?? this.minPrice),
      maxPrice: clearPrice ? null : (maxPrice ?? this.maxPrice),
      search: search ?? this.search,
    );
  }

  ProductFilterState cleared() => const ProductFilterState();
}

class PriceRange {
  const PriceRange({required this.min, required this.max});

  final double min;
  final double max;
}
