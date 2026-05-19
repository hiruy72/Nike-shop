import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/core/theme/app_colors.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_category.dart';
import 'package:shop/models/product_filter_state.dart';
import 'package:shop/widgets/filter_bottom_sheet.dart';

class MasterFilterBar extends StatelessWidget {
  const MasterFilterBar({
    super.key,
    required this.filter,
    required this.onFilterChanged,
    required this.onClearAll,
  });

  final ProductFilterState filter;
  final ValueChanged<ProductFilterState> onFilterChanged;
  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 44,
            child: Row(
              children: [
                _GenderPill(
                  label: 'All',
                  icon: Icons.grid_view,
                  selected: filter.gender == null,
                  onTap: onClearAll,
                ),
                const SizedBox(width: 8),
                _GenderPill(
                  label: 'Men',
                  icon: Icons.man,
                  selected: filter.gender == ProductGender.men,
                  onTap: () => onFilterChanged(
                    filter.copyWith(gender: ProductGender.men, clearCategory: true),
                  ),
                ),
                const SizedBox(width: 8),
                _GenderPill(
                  label: 'Women',
                  icon: Icons.woman,
                  selected: filter.gender == ProductGender.women,
                  onTap: () => onFilterChanged(
                    filter.copyWith(gender: ProductGender.women, clearCategory: true),
                  ),
                ),
                const SizedBox(width: 8),
                _GenderPill(
                  label: 'Kids',
                  icon: Icons.child_care,
                  selected: filter.gender == ProductGender.kids,
                  onTap: () => onFilterChanged(
                    filter.copyWith(gender: ProductGender.kids, clearCategory: true),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => FilterBottomSheet.show(
                    context,
                    initial: filter,
                    onApply: onFilterChanged,
                  ),
                  icon: const Icon(Icons.tune, size: 18),
                  label: const Text('Filters'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
              if (filter.activeFilterCount > 0) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${filter.activeFilterCount}',
                    style: theme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (filter.hasActiveFilters) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ..._activeChips(context),
                  TextButton(
                    onPressed: onClearAll,
                    child: Text(
                      'Clear all',
                      style: theme.labelMedium?.copyWith(
                        color: AppColors.accent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> _activeChips(BuildContext context) {
    final chips = <Widget>[];

    if (filter.gender != null) {
      chips.add(_ActiveChip(
        label: filter.gender!.name[0].toUpperCase() +
            filter.gender!.name.substring(1),
        onRemove: () => onFilterChanged(filter.copyWith(clearGender: true)),
      ));
    }
    if (filter.category != null) {
      chips.add(_ActiveChip(
        label: filter.category!.label,
        onRemove: () => onFilterChanged(filter.copyWith(clearCategory: true)),
      ));
    }
    if (filter.minPrice != null || filter.maxPrice != null) {
      chips.add(_ActiveChip(
        label:
            '\$${filter.minPrice?.round() ?? 0}–\$${filter.maxPrice?.round() ?? 0}',
        onRemove: () => onFilterChanged(filter.copyWith(clearPrice: true)),
      ));
    }
    if (filter.sort != ProductSort.featured) {
      chips.add(_ActiveChip(
        label: _sortShort(filter.sort),
        onRemove: () => onFilterChanged(
          filter.copyWith(sort: ProductSort.featured),
        ),
      ));
    }

    return chips;
  }

  String _sortShort(ProductSort sort) {
    switch (sort) {
      case ProductSort.featured:
        return 'Featured';
      case ProductSort.priceAsc:
        return 'Price ↑';
      case ProductSort.priceDesc:
        return 'Price ↓';
      case ProductSort.rating:
        return 'Top rated';
      case ProductSort.name:
        return 'A–Z';
    }
  }
}

class _GenderPill extends StatelessWidget {
  const _GenderPill({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          height: 44,
          decoration: BoxDecoration(
            color: selected ? AppColors.accent : AppColors.cardBackground,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: selected ? Colors.white : AppColors.secondaryText,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  color: selected ? Colors.white : AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActiveChip extends StatelessWidget {
  const _ActiveChip({required this.label, required this.onRemove});

  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InputChip(
        label: Text(label),
        deleteIcon: const Icon(Icons.close, size: 16),
        onDeleted: onRemove,
        backgroundColor: AppColors.cardBackground,
        side: BorderSide.none,
        labelStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
