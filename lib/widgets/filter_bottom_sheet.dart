import 'package:flutter/material.dart';
import 'package:shop/core/theme/app_colors.dart';
import 'package:shop/data/category_icons.dart';
import 'package:shop/data/mock_data.dart';
import 'package:shop/models/product_filter_state.dart';
import 'package:shop/models/product_category.dart';
import 'package:shop/utils/product_filter_logic.dart';
import 'package:shop/widgets/primary_button.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    super.key,
    required this.initial,
    required this.onApply,
  });

  final ProductFilterState initial;
  final ValueChanged<ProductFilterState> onApply;

  static Future<void> show(
    BuildContext context, {
    required ProductFilterState initial,
    required ValueChanged<ProductFilterState> onApply,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => FilterBottomSheet(initial: initial, onApply: onApply),
    );
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late ProductCategory? _category;
  late ProductSort _sort;
  late RangeValues _priceRange;
  late PriceRange _catalogRange;

  @override
  void initState() {
    super.initState();
    _category = widget.initial.category;
    _sort = widget.initial.sort;
    _catalogRange = ProductFilterLogic.catalogRange(products);
    _priceRange = RangeValues(
      widget.initial.minPrice ?? _catalogRange.min,
      widget.initial.maxPrice ?? _catalogRange.max,
    );
  }

  void _reset() {
    setState(() {
      _category = null;
      _sort = ProductSort.featured;
      _priceRange = RangeValues(_catalogRange.min, _catalogRange.max);
    });
  }

  void _apply() {
    final priceFiltered = _priceRange.start > _catalogRange.min ||
        _priceRange.end < _catalogRange.max;

    widget.onApply(
      widget.initial.copyWith(
        category: _category,
        clearCategory: _category == null,
        sort: _sort,
        minPrice: priceFiltered ? _priceRange.start : null,
        maxPrice: priceFiltered ? _priceRange.end : null,
        clearPrice: !priceFiltered,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.82,
        minChildSize: 0.5,
        maxChildSize: 0.92,
        builder: (_, scrollController) {
          return Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Row(
                  children: [
                    Text(
                      'Filters',
                      style: theme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    TextButton(onPressed: _reset, child: const Text('Reset')),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Text(
                      'Category',
                      style: theme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 2.8,
                      ),
                      itemCount: ProductCategory.values.length,
                      itemBuilder: (_, index) {
                        final cat = ProductCategory.values[index];
                        final selected = _category == cat;
                        return Material(
                          color: selected
                              ? AppColors.accent.withValues(alpha: 0.12)
                              : AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(14),
                          child: InkWell(
                            onTap: () => setState(
                              () => _category = selected ? null : cat,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: selected
                                      ? AppColors.accent
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    iconForCategory(cat),
                                    size: 20,
                                    color: selected
                                        ? AppColors.accent
                                        : AppColors.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      cat.label,
                                      style: theme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: selected
                                            ? AppColors.accent
                                            : AppColors.primary,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Price range',
                      style: theme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${_priceRange.start.round()} – \$${_priceRange.end.round()}',
                      style: theme.bodyMedium?.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                    RangeSlider(
                      values: _priceRange,
                      min: _catalogRange.min,
                      max: _catalogRange.max,
                      divisions: 20,
                      activeColor: AppColors.accent,
                      onChanged: (v) => setState(() => _priceRange = v),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Sort by',
                      style: theme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    ...ProductSort.values.map((sort) {
                      final selected = _sort == sort;
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(_sortLabel(sort)),
                        trailing: Icon(
                          selected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: selected
                              ? AppColors.accent
                              : AppColors.secondaryText,
                        ),
                        onTap: () => setState(() => _sort = sort),
                      );
                    }),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: PrimaryButton(label: 'Apply Filters', onPressed: _apply),
              ),
            ],
          );
        },
      ),
    );
  }

  String _sortLabel(ProductSort sort) {
    switch (sort) {
      case ProductSort.featured:
        return 'Featured';
      case ProductSort.priceAsc:
        return 'Price: Low to High';
      case ProductSort.priceDesc:
        return 'Price: High to Low';
      case ProductSort.rating:
        return 'Top rated';
      case ProductSort.name:
        return 'Name: A–Z';
    }
  }
}
