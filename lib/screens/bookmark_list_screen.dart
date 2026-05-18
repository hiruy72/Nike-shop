import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/theme/app_colors.dart';
import 'package:shop/data/mock_data.dart';
import 'package:shop/models/cart_line.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/bookmark_provider.dart';
import 'package:shop/widgets/cart_item_tile.dart';
import 'package:shop/widgets/shop_app_bar.dart';

class BookmarkListScreen extends StatelessWidget {
  const BookmarkListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final bookmarks = context.watch<BookmarkProvider>();
    final bookmarkedProducts = products
        .where((p) => bookmarks.isBookmarked(p.id))
        .toList();

    return Scaffold(
      appBar: const ShopTitledAppBar(title: 'Bookmarks'),
      body: bookmarkedProducts.isEmpty
          ? Center(
              child: Text(
                'No bookmarks yet',
                style: theme.bodyLarge?.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: bookmarkedProducts.length,
              itemBuilder: (context, index) {
                final product = bookmarkedProducts[index];
                final line = CartLine(
                  product: product,
                  size: product.sizesUs.first,
                  region: SizeRegion.us,
                );
                return CartItemTile(line: line, showQuantity: false);
              },
            ),
    );
  }
}
