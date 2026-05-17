import 'package:flutter/material.dart';
import 'package:shop/app.dart';
import 'package:shop/core/theme/app_colors.dart';
import 'package:shop/data/mock_data.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_category.dart';
import 'package:shop/widgets/category_sections.dart';
import 'package:shop/widgets/shop_app_bar.dart';
import 'package:shop/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductGender? _selectedGender;
  ProductCategory? _selectedCategory;
  String _searchQuery = '';

  List<Product> get _filteredProducts {
    return products.where((p) {
      final matchesGender =
          _selectedGender == null || p.gender == _selectedGender;
      final matchesCategory = _selectedCategory == null ||
          p.productCategory == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          p.name.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesGender && matchesCategory && matchesSearch;
    }).toList();
  }

  void _onGenderChanged(ProductGender? gender) {
    setState(() {
      _selectedGender = gender;
      _selectedCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final filtered = _filteredProducts;

    return Scaffold(
      appBar: const ShopLogoAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Arrivals',
                    style: theme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Find your next pair',
                    style: theme.bodyMedium?.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (v) => setState(() => _searchQuery = v),
                    decoration: InputDecoration(
                      hintText: 'Search shoes...',
                      hintStyle: TextStyle(
                        color: AppColors.secondaryText.withValues(alpha: 0.8),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.secondaryText,
                      ),
                      filled: true,
                      fillColor: AppColors.cardBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: CategorySections(
              selectedGender: _selectedGender,
              selectedCategory: _selectedCategory,
              onGenderChanged: _onGenderChanged,
              onCategoryChanged: (category) =>
                  setState(() => _selectedCategory = category),
              onClearAll: () => setState(() {
                _selectedGender = null;
                _selectedCategory = null;
              }),
            ),
          ),
          if (filtered.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text('No products in this category')),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.62,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = filtered[index];
                    return ProductCard(
                      product: product,
                      onTap: () => Navigator.pushNamed(
                        context,
                        ShopApp.productRoute,
                        arguments: product.id,
                      ),
                    );
                  },
                  childCount: filtered.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
