import 'package:flutter/material.dart';
import 'package:shop/core/theme/app_colors.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.borderRadius,
    this.fillParent = false,
  });

  final String? imageUrl;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final bool fillParent;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(16);

    Widget child;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      child = Image.network(
        imageUrl!,
        fit: fit,
        width: fillParent ? double.infinity : null,
        height: fillParent ? double.infinity : null,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
        loadingBuilder: (_, child, progress) {
          if (progress == null) return child;
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        },
      );
    } else {
      child = _placeholder();
    }

    final content = fillParent
        ? SizedBox.expand(child: child)
        : child;

    return ClipRRect(
      borderRadius: radius,
      child: Container(
        color: AppColors.cardBackground,
        child: content,
      ),
    );
  }

  Widget _placeholder() {
    return const Center(
      child: Icon(
        Icons.sports_soccer,
        size: 48,
        color: AppColors.secondaryText,
      ),
    );
  }
}
