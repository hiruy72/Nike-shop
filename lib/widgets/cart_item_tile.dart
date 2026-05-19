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
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: ProductImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                fillParent: true,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            line.product.name,
                            style: theme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Size ${line.size}',
                            style: theme.bodySmall?.copyWith(
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => bookmarks.toggle(line.product),
                      icon: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${line.product.price.toStringAsFixed(2)}',
                  style: theme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                if (showQuantity) ...[
                  const SizedBox(height: 12),
                  QuantityStepper(
                    quantity: line.quantity,
                    onIncrement: () => cart.increment(line.id),
                    onDecrement: () => cart.decrement(line.id),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
