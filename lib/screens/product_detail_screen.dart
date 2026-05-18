import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/theme/app_colors.dart';
import 'package:shop/data/mock_data.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/bookmark_provider.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/widgets/primary_button.dart';
import 'package:shop/widgets/shop_app_bar.dart';
import 'package:shop/widgets/product_image.dart';
import 'package:shop/widgets/review_card.dart';
import 'package:shop/widgets/size_selector.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _pageController = PageController();
  int _carouselIndex = 0;
  SizeRegion _region = SizeRegion.us;
  String? _selectedSize;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = productById(widget.productId);
    if (product == null) {
      return Scaffold(
        appBar: const ShopLogoAppBar(showBack: true),
        body: const Center(child: Text('Product not found')),
      );
    }

    final sizes = product.sizesFor(_region);
    _selectedSize ??= sizes.contains('5.5') ? '5.5' : sizes.first;
    if (!sizes.contains(_selectedSize)) {
      _selectedSize = sizes.first;
    }

    final theme = Theme.of(context).textTheme;
    final bookmarks = context.watch<BookmarkProvider>();
    final isBookmarked = bookmarks.isBookmarked(product.id);
    final cart = context.read<CartProvider>();

    return Scaffold(
      appBar: const ShopLogoAppBar(showBack: true),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Row(
            children: [
              OutlineIconButton(
                icon: isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                isActive: isBookmarked,
                onPressed: () => bookmarks.toggle(product),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PrimaryButton(
                  label: 'Add to Cart',
                  onPressed: () {
                    cart.addItem(product, _selectedSize!, _region);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to bag'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ImageCarousel(
              product: product,
              pageController: _pageController,
              currentIndex: _carouselIndex,
              onPageChanged: (i) => setState(() => _carouselIndex = i),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Text(
                product.category,
                style: theme.bodyMedium?.copyWith(color: AppColors.secondaryText),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: theme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: theme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                children: [
                  const Icon(Icons.star, color: AppColors.accent, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    '(${product.rating})',
                    style: theme.bodyMedium?.copyWith(color: AppColors.secondaryText),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            SizeSelector(
              product: product,
              region: _region,
              selectedSize: _selectedSize,
              onRegionChanged: (r) => setState(() {
                _region = r;
                final newSizes = product.sizesFor(r);
                _selectedSize = newSizes.contains(_selectedSize)
                    ? _selectedSize
                    : newSizes.first;
              }),
              onSizeChanged: (s) => setState(() => _selectedSize = s),
            ),
            const SizedBox(height: 16),
            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: Column(
                children: [
                  ExpansionTile(
                    title: Text(
                      'Description',
                      style: theme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                        child: Text(
                          product.description,
                          style: theme.bodyMedium?.copyWith(
                            color: AppColors.secondaryText,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Free Delivery and Returns',
                      style: theme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                        child: Text(
                          product.deliveryInfo ?? '',
                          style: theme.bodyMedium?.copyWith(
                            color: AppColors.secondaryText,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'See Reviews',
                      style: theme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            ...reviews.map((r) => ReviewCard(review: r)),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'More Reviews',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _ImageCarousel extends StatelessWidget {
  const _ImageCarousel({
    required this.product,
    required this.pageController,
    required this.currentIndex,
    required this.onPageChanged,
  });

  final Product product;
  final PageController pageController;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  List<String> get _carouselImages {
    final source = product.images;
    if (source.length >= 3) return source.take(3).toList();
    return List.generate(3, (i) => source[i % source.length]);
  }

  @override
  Widget build(BuildContext context) {
    final images = _carouselImages;

    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
          child: Container(
            width: double.infinity,
            height: 320,
            color: AppColors.cardBackground,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: onPageChanged,
              itemCount: images.length,
              itemBuilder: (_, index) {
                return ProductImage(
                  imageUrl: images[index],
                  fit: BoxFit.cover,
                  fillParent: true,
                  borderRadius: BorderRadius.zero,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(images.length, (i) {
            final isActive = i == currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.secondaryText.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),
        ),
      ],
    );
  }
}
