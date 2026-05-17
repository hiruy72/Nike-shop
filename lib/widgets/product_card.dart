import 'package:flutter/material.dart';
import 'package:shop/core/theme/app_colors.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/product_image.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ProductImage(
              imageUrl: product.images.isNotEmpty ? product.images.first : null,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.category,
            style: theme.bodySmall?.copyWith(color: AppColors.secondaryText),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            product.name,
            style: theme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: theme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              const Icon(Icons.star, color: AppColors.accent, size: 16),
              const SizedBox(width: 4),
              Text(
                '(${product.rating})',
                style: theme.bodySmall?.copyWith(color: AppColors.secondaryText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
