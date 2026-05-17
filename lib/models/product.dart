import 'package:shop/models/product_category.dart';

enum ProductGender { men, women, kids }

enum SizeRegion { us, uk, eu }

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.gender,
    required this.productCategory,
    required this.price,
    required this.rating,
    required this.images,
    required this.sizesUs,
    required this.sizesUk,
    required this.sizesEu,
    required this.description,
    this.deliveryInfo,
  });

  final String id;
  final String name;
  final String category;
  final ProductGender gender;
  final ProductCategory productCategory;
  final double price;
  final double rating;
  final List<String> images;
  final List<String> sizesUs;
  final List<String> sizesUk;
  final List<String> sizesEu;
  final String description;
  final String? deliveryInfo;

  List<String> sizesFor(SizeRegion region) {
    switch (region) {
      case SizeRegion.us:
        return sizesUs;
      case SizeRegion.uk:
        return sizesUk;
      case SizeRegion.eu:
        return sizesEu;
    }
  }

  String get genderLabel {
    switch (gender) {
      case ProductGender.men:
        return 'Men';
      case ProductGender.women:
        return 'Women';
      case ProductGender.kids:
        return 'Kids';
    }
  }
}
