import 'package:shop/models/product.dart';
import 'package:shop/models/product_category.dart';

class CategoryFilter {
  const CategoryFilter({
    required this.gender,
    required this.category,
  });

  final ProductGender gender;
  final ProductCategory category;

  @override
  bool operator ==(Object other) {
    return other is CategoryFilter &&
        other.gender == gender &&
        other.category == category;
  }

  @override
  int get hashCode => Object.hash(gender, category);
}
