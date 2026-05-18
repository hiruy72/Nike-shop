import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/theme/app_colors.dart';
import 'package:shop/models/cart_line.dart';
import 'package:shop/providers/bookmark_provider.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/widgets/product_image.dart';
import 'package:shop/widgets/quantity_stepper.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.line,
    this.showQuantity = true,
  });

  final CartLine line;
  final bool showQuantity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final cart = context.read<CartProvider>();
    final bookmarks = context.watch<BookmarkProvider>();
    final isBookmarked = bookmarks.isBookmarked(line.product.id);
    final imageUrl =
        line.product.images.isNotEmpty ? line.product.images.first : null;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: ProductImage(imageUrl: imageUrl),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  line.product.name,
                  style: theme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${line.product.price.toStringAsFixed(2)}',
                  style: theme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                if (showQuantity) ...[
                  const SizedBox(height: 10),
                  QuantityStepper(
                    quantity: line.quantity,
                    onIncrement: () => cart.increment(line.id),
                    onDecrement: () => cart.decrement(line.id),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: () => bookmarks.toggle(line.product),
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}
