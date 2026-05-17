import 'package:flutter/material.dart';
import 'package:shop/core/theme/app_colors.dart';
import 'package:shop/models/product.dart';

class SizeSelector extends StatelessWidget {
  const SizeSelector({
    super.key,
    required this.product,
    required this.region,
    required this.selectedSize,
    required this.onRegionChanged,
    required this.onSizeChanged,
  });

  final Product product;
  final SizeRegion region;
  final String? selectedSize;
  final ValueChanged<SizeRegion> onRegionChanged;
  final ValueChanged<String> onSizeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final sizes = product.sizesFor(region);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Size:', style: theme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(width: 16),
              _RegionTab(
                label: 'US',
                selected: region == SizeRegion.us,
                onTap: () => onRegionChanged(SizeRegion.us),
              ),
              _RegionTab(
                label: 'UK',
                selected: region == SizeRegion.uk,
                onTap: () => onRegionChanged(SizeRegion.uk),
              ),
              _RegionTab(
                label: 'EU',
                selected: region == SizeRegion.eu,
                onTap: () => onRegionChanged(SizeRegion.eu),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: sizes.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final size = sizes[index];
                final isSelected = size == selectedSize;
                return GestureDetector(
                  onTap: () => onSizeChanged(size),
                  child: Container(
                    width: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.accent : AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      size,
                      style: theme.titleSmall?.copyWith(
                        color: isSelected ? Colors.white : AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RegionTab extends StatelessWidget {
  const _RegionTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.primary : AppColors.secondaryText,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
