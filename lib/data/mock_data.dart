import 'package:shop/models/cart_line.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_category.dart';
import 'package:shop/models/review.dart';

const _deliveryCopy =
    'Free standard delivery on orders over \$150. Free returns within 30 days. '
    'Items must be unworn and in original packaging.';

const _imagePool = [
  'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600',
  'https://images.unsplash.com/photo-1606107557195-0f40c3a2c4a3?w=600',
  'https://images.unsplash.com/photo-1608231387043-66d1773070a5?w=600',
  'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=600',
  'https://images.unsplash.com/photo-1460353581641-37baddab0fa2?w=600',
  'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?w=600',
  'https://images.unsplash.com/photo-1560769629-975ec094e6ae?w=600',
  'https://images.unsplash.com/photo-1514986880722-c0cc690f934a?w=600',
  'https://images.unsplash.com/photo-1603487742131-416a7f39e8ec?w=600',
  'https://images.unsplash.com/photo-1607522370275-f14206abe5d3?w=600',
];

const _menSizesUs = ['7', '8', '9', '10', '11'];
const _menSizesUk = ['6', '7', '8', '9', '10'];
const _menSizesEu = ['40', '41', '42', '43', '44'];

const _womenSizesUs = ['5', '6', '7', '8', '9'];
const _womenSizesUk = ['3', '4', '5', '6', '7'];
const _womenSizesEu = ['36', '37', '38', '39', '40'];

const _kidsSizesUs = ['10C', '11C', '12C', '13C'];
const _kidsSizesUk = ['9', '10', '11', '12'];
const _kidsSizesEu = ['27', '28', '29', '30'];

Product _product({
  required String id,
  required String name,
  required ProductGender gender,
  required ProductCategory productCategory,
  required double price,
  double rating = 4.5,
  int imageIndex = 0,
  List<String>? images,
}) {
  final genderPrefix = switch (gender) {
    ProductGender.men => "Men's",
    ProductGender.women => "Women's",
    ProductGender.kids => "Kids'",
  };

  final (sizesUs, sizesUk, sizesEu) = switch (gender) {
    ProductGender.men => (_menSizesUs, _menSizesUk, _menSizesEu),
    ProductGender.women => (_womenSizesUs, _womenSizesUk, _womenSizesEu),
    ProductGender.kids => (_kidsSizesUs, _kidsSizesUk, _kidsSizesEu),
  };

  List<String> threeImages(int start) => List.generate(
        3,
        (i) => _imagePool[(start + i) % _imagePool.length],
      );

  return Product(
    id: id,
    name: name,
    category: "$genderPrefix ${productCategory.label}",
    gender: gender,
    productCategory: productCategory,
    price: price,
    rating: rating,
    images: images ?? threeImages(imageIndex),
    sizesUs: sizesUs,
    sizesUk: sizesUk,
    sizesEu: sizesEu,
    description:
        'Premium Nike ${productCategory.label.toLowerCase()} footwear built for comfort, durability, and style.',
    deliveryInfo: _deliveryCopy,
  );
}

final List<Product> products = [
  _product(
    id: 'air-max',
    name: 'Nike Air Max',
    gender: ProductGender.men,
    productCategory: ProductCategory.airMax,
    price: 290,
    rating: 4.5,
    imageIndex: 0,
  ),
  _product(
    id: 'wmns-runner',
    name: 'Nike Wmns Runner',
    gender: ProductGender.women,
    productCategory: ProductCategory.running,
    price: 240,
    rating: 4.3,
    imageIndex: 3,
  ),
  _product(
    id: 'react-infinity',
    name: 'Nike React Infinity',
    gender: ProductGender.men,
    productCategory: ProductCategory.running,
    price: 160,
    rating: 4.7,
    imageIndex: 4,
  ),
  _product(
    id: 'air-force',
    name: 'Nike Air Force 1',
    gender: ProductGender.men,
    productCategory: ProductCategory.lifestyle,
    price: 110,
    rating: 4.8,
    imageIndex: 5,
  ),
  _product(
    id: 'blazer-mid',
    name: 'Nike Blazer Mid',
    gender: ProductGender.women,
    productCategory: ProductCategory.retro,
    price: 100,
    rating: 4.4,
    imageIndex: 6,
  ),
  _product(
    id: 'kids-flex',
    name: 'Nike Flex Runner',
    gender: ProductGender.kids,
    productCategory: ProductCategory.running,
    price: 65,
    rating: 4.6,
    imageIndex: 7,
  ),
  _product(
    id: 'pegasus',
    name: 'Nike Pegasus',
    gender: ProductGender.women,
    productCategory: ProductCategory.training,
    price: 130,
    rating: 4.5,
    imageIndex: 8,
  ),
  _product(
    id: 'dunk-low',
    name: 'Nike Dunk Low',
    gender: ProductGender.men,
    productCategory: ProductCategory.lowTops,
    price: 120,
    rating: 4.9,
    imageIndex: 9,
  ),
  _product(id: 'm-run-2', name: 'Nike Zoom Fly', gender: ProductGender.men, productCategory: ProductCategory.running, price: 150, imageIndex: 1),
  _product(id: 'm-walk-1', name: 'Nike Motiva', gender: ProductGender.men, productCategory: ProductCategory.walking, price: 95, imageIndex: 2),
  _product(id: 'm-bball-1', name: 'Nike LeBron Witness', gender: ProductGender.men, productCategory: ProductCategory.basketball, price: 140, imageIndex: 3),
  _product(id: 'm-train-1', name: 'Nike Metcon 9', gender: ProductGender.men, productCategory: ProductCategory.training, price: 145, imageIndex: 4),
  _product(id: 'm-life-2', name: 'Nike Court Vision', gender: ProductGender.men, productCategory: ProductCategory.lifestyle, price: 85, imageIndex: 5),
  _product(id: 'm-skate-1', name: 'Nike SB Dunk', gender: ProductGender.men, productCategory: ProductCategory.skateboarding, price: 115, imageIndex: 6),
  _product(id: 'm-soccer-1', name: 'Nike Phantom GX', gender: ProductGender.men, productCategory: ProductCategory.soccer, price: 275, imageIndex: 7),
  _product(id: 'm-tennis-1', name: 'Nike Vapor Lite', gender: ProductGender.men, productCategory: ProductCategory.tennis, price: 90, imageIndex: 8),
  _product(id: 'm-golf-1', name: 'Nike Infinity Tour', gender: ProductGender.men, productCategory: ProductCategory.golf, price: 180, imageIndex: 9),
  _product(id: 'm-sandal-1', name: 'Nike Victori One', gender: ProductGender.men, productCategory: ProductCategory.sandals, price: 35, imageIndex: 0),
  _product(id: 'm-boot-1', name: 'Nike Manoa', gender: ProductGender.men, productCategory: ProductCategory.boots, price: 125, imageIndex: 1),
  _product(id: 'm-jordan-1', name: 'Air Jordan 1', gender: ProductGender.men, productCategory: ProductCategory.jordan, price: 180, imageIndex: 2),
  _product(id: 'm-retro-1', name: 'Nike Cortez', gender: ProductGender.men, productCategory: ProductCategory.retro, price: 90, imageIndex: 3),
  _product(id: 'm-trail-1', name: 'Nike Pegasus Trail', gender: ProductGender.men, productCategory: ProductCategory.trail, price: 155, imageIndex: 4),
  _product(id: 'm-gym-1', name: 'Nike SuperRep Go', gender: ProductGender.men, productCategory: ProductCategory.gym, price: 100, imageIndex: 5),
  _product(id: 'm-casual-1', name: 'Nike Killshot 2', gender: ProductGender.men, productCategory: ProductCategory.casual, price: 95, imageIndex: 6),
  _product(id: 'm-high-1', name: 'Nike Dunk High', gender: ProductGender.men, productCategory: ProductCategory.highTops, price: 125, imageIndex: 7),
  _product(id: 'm-ltd-1', name: 'Nike Air Max 1 OG', gender: ProductGender.men, productCategory: ProductCategory.limitedEdition, price: 220, imageIndex: 8),
  _product(id: 'm-cleat-1', name: 'Nike Mercurial', gender: ProductGender.men, productCategory: ProductCategory.cleats, price: 260, imageIndex: 9),
  _product(id: 'w-run-1', name: 'Nike Revolution 7', gender: ProductGender.women, productCategory: ProductCategory.running, price: 70, imageIndex: 0),
  _product(id: 'w-walk-1', name: 'Nike Journey Run', gender: ProductGender.women, productCategory: ProductCategory.walking, price: 88, imageIndex: 1),
  _product(id: 'w-bball-1', name: 'Nike Cosmic Unity', gender: ProductGender.women, productCategory: ProductCategory.basketball, price: 130, imageIndex: 2),
  _product(id: 'w-life-1', name: 'Nike Air Max DN', gender: ProductGender.women, productCategory: ProductCategory.lifestyle, price: 200, imageIndex: 3),
  _product(id: 'w-skate-1', name: 'Nike SB Shane', gender: ProductGender.women, productCategory: ProductCategory.skateboarding, price: 95, imageIndex: 4),
  _product(id: 'w-tennis-1', name: 'Nike Court Lite', gender: ProductGender.women, productCategory: ProductCategory.tennis, price: 75, imageIndex: 5),
  _product(id: 'w-air-1', name: 'Nike Air Max 90', gender: ProductGender.women, productCategory: ProductCategory.airMax, price: 135, imageIndex: 6),
  _product(id: 'w-jordan-1', name: 'Air Jordan 4 RM', gender: ProductGender.women, productCategory: ProductCategory.jordan, price: 160, imageIndex: 7),
  _product(id: 'w-trail-1', name: 'Nike Wildhorse 8', gender: ProductGender.women, productCategory: ProductCategory.trail, price: 140, imageIndex: 8),
  _product(id: 'w-casual-1', name: 'Nike Daybreak', gender: ProductGender.women, productCategory: ProductCategory.casual, price: 105, imageIndex: 9),
  _product(id: 'w-low-1', name: 'Nike Court Royale', gender: ProductGender.women, productCategory: ProductCategory.lowTops, price: 70, imageIndex: 0),
  _product(id: 'w-gym-1', name: 'Nike Free Metcon', gender: ProductGender.women, productCategory: ProductCategory.gym, price: 120, imageIndex: 1),
  _product(id: 'w-sandal-1', name: 'Nike Benassi', gender: ProductGender.women, productCategory: ProductCategory.sandals, price: 30, imageIndex: 2),
  _product(id: 'w-boot-1', name: 'Nike Lahar Low', gender: ProductGender.women, productCategory: ProductCategory.boots, price: 115, imageIndex: 3),
  _product(id: 'w-golf-1', name: 'Nike Air Zoom Victory', gender: ProductGender.women, productCategory: ProductCategory.golf, price: 170, imageIndex: 4),
  _product(id: 'w-soccer-1', name: 'Nike Tiempo', gender: ProductGender.women, productCategory: ProductCategory.soccer, price: 250, imageIndex: 5),
  _product(id: 'w-ltd-1', name: 'Nike P-6000', gender: ProductGender.women, productCategory: ProductCategory.limitedEdition, price: 115, imageIndex: 6),
  _product(id: 'w-high-1', name: 'Nike Blazer Mid 77', gender: ProductGender.women, productCategory: ProductCategory.highTops, price: 110, imageIndex: 7),
  _product(id: 'w-cleat-1', name: 'Nike Phantom Luna', gender: ProductGender.women, productCategory: ProductCategory.cleats, price: 265, imageIndex: 8),
  _product(id: 'k-run-2', name: 'Nike Star Runner', gender: ProductGender.kids, productCategory: ProductCategory.running, price: 55, imageIndex: 9),
  _product(id: 'k-walk-1', name: 'Nike Pico 5', gender: ProductGender.kids, productCategory: ProductCategory.walking, price: 45, imageIndex: 0),
  _product(id: 'k-bball-1', name: 'Nike Team Hustle', gender: ProductGender.kids, productCategory: ProductCategory.basketball, price: 60, imageIndex: 1),
  _product(id: 'k-life-1', name: 'Nike Air Max SC', gender: ProductGender.kids, productCategory: ProductCategory.lifestyle, price: 80, imageIndex: 2),
  _product(id: 'k-train-1', name: 'Nike Flex Runner 2', gender: ProductGender.kids, productCategory: ProductCategory.training, price: 58, imageIndex: 3),
  _product(id: 'k-casual-1', name: 'Nike Court Borough', gender: ProductGender.kids, productCategory: ProductCategory.casual, price: 50, imageIndex: 4),
  _product(id: 'k-soccer-1', name: 'Nike Jr. Phantom', gender: ProductGender.kids, productCategory: ProductCategory.soccer, price: 75, imageIndex: 5),
  _product(id: 'k-sandal-1', name: 'Nike Kawa', gender: ProductGender.kids, productCategory: ProductCategory.sandals, price: 25, imageIndex: 6),
  _product(id: 'k-jordan-1', name: 'Jordan 1 Low', gender: ProductGender.kids, productCategory: ProductCategory.jordan, price: 95, imageIndex: 7),
  _product(id: 'k-retro-1', name: 'Nike Cortez Kids', gender: ProductGender.kids, productCategory: ProductCategory.retro, price: 70, imageIndex: 8),
  _product(id: 'k-low-1', name: 'Nike WearAllDay', gender: ProductGender.kids, productCategory: ProductCategory.lowTops, price: 48, imageIndex: 9),
  _product(id: 'k-high-1', name: 'Nike Dunk High Kids', gender: ProductGender.kids, productCategory: ProductCategory.highTops, price: 85, imageIndex: 0),
  _product(id: 'k-gym-1', name: 'Nike Multi-Court', gender: ProductGender.kids, productCategory: ProductCategory.gym, price: 52, imageIndex: 1),
  _product(id: 'k-skate-1', name: 'Nike SB Stefan', gender: ProductGender.kids, productCategory: ProductCategory.skateboarding, price: 68, imageIndex: 2),
  _product(id: 'k-trail-1', name: 'Nike Terra Manta', gender: ProductGender.kids, productCategory: ProductCategory.trail, price: 62, imageIndex: 3),
  _product(id: 'k-air-1', name: 'Nike Air Max 270', gender: ProductGender.kids, productCategory: ProductCategory.airMax, price: 110, imageIndex: 4),
  _product(id: 'k-ltd-1', name: 'Nike Cosmic Runner', gender: ProductGender.kids, productCategory: ProductCategory.limitedEdition, price: 90, imageIndex: 5),
  _product(id: 'k-cleat-1', name: 'Nike Jr. Mercurial', gender: ProductGender.kids, productCategory: ProductCategory.cleats, price: 72, imageIndex: 6),
  _product(id: 'k-boot-1', name: 'Nike Manoa Kids', gender: ProductGender.kids, productCategory: ProductCategory.boots, price: 78, imageIndex: 7),
  _product(id: 'k-tennis-1', name: 'Nike Court Borough 2', gender: ProductGender.kids, productCategory: ProductCategory.tennis, price: 55, imageIndex: 8),
  _product(id: 'k-golf-1', name: 'Nike Infinity Tour Kids', gender: ProductGender.kids, productCategory: ProductCategory.golf, price: 85, imageIndex: 9),
];

Product? productById(String id) {
  try {
    return products.firstWhere((p) => p.id == id);
  } catch (_) {
    return null;
  }
}

final List<Review> reviews = [
  const Review(
    author: 'Royal Parvej',
    rating: 5,
    text:
        'Amazing comfort and style. True to size and the cushioning is perfect for daily wear.',
    date: '10.02.2020',
  ),
  const Review(
    author: 'Sarah Mitchell',
    rating: 4,
    text: 'Great shoes overall. Took a few days to break in but worth it.',
    date: '15.03.2020',
  ),
  const Review(
    author: 'James Chen',
    rating: 5,
    text: 'Best purchase this year. Quality materials and sleek design.',
    date: '22.01.2021',
  ),
];

List<CartLine> buildInitialCart() {
  final airMax = products.firstWhere((p) => p.id == 'air-max');
  final wmns = products.firstWhere((p) => p.id == 'wmns-runner');
  final react = products.firstWhere((p) => p.id == 'react-infinity');

  return [
    CartLine(product: airMax, size: '5.5', region: SizeRegion.us, quantity: 1),
    CartLine(product: wmns, size: '6', region: SizeRegion.us, quantity: 1),
    CartLine(product: react, size: '9', region: SizeRegion.us, quantity: 1),
  ];
}
