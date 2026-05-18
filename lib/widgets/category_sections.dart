import 'package:flutter/material.dart';
import 'package:shop/core/theme/app_colors.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_category.dart';

class CategorySections extends StatelessWidget {
  const CategorySections({
    super.key,
    required this.selectedGender,
    required this.selectedCategory,
    required this.onGenderChanged,
    required this.onCategoryChanged,
    required this.onClearAll,
  });

  final ProductGender? selectedGender;
  final ProductCategory? selectedCategory;
  final ValueChanged<ProductGender?> onGenderChanged;
  final ValueChanged<ProductCategory?> onCategoryChanged;
  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: _GenderChip(
                    label: 'All',
                    selected: selectedGender == null,
                    onTap: onClearAll,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _GenderChip(
                    label: 'Men',
                    selected: selectedGender == ProductGender.men,
                    onTap: () => onGenderChanged(ProductGender.men),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _GenderChip(
                    label: 'Women',
                    selected: selectedGender == ProductGender.women,
                    onTap: () => onGenderChanged(ProductGender.women),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _GenderChip(
                    label: 'Kids',
                    selected: selectedGender == ProductGender.kids,
                    onTap: () => onGenderChanged(ProductGender.kids),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Category',
            style: theme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<ProductCategory?>(
            key: ValueKey(selectedCategory),
            initialValue: selectedCategory,
            isExpanded: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.cardBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            ),
            hint: Text(
              selectedGender == null
                  ? 'Select Men, Women, or Kids first'
                  : 'All categories',
              style: theme.bodyMedium?.copyWith(color: AppColors.secondaryText),
            ),
            items: [
              const DropdownMenuItem<ProductCategory?>(
                value: null,
                child: Text('All categories'),
              ),
              ...ProductCategory.values.map(
                (category) => DropdownMenuItem<ProductCategory?>(
                  value: category,
                  child: Text(category.label),
                ),
              ),
            ],
            onChanged: selectedGender == null ? null : onCategoryChanged,
          ),
        ],
      ),
    );
  }
}

class _GenderChip extends StatelessWidget {
  const _GenderChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.accent : AppColors.cardBackground,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          alignment: Alignment.center,
          height: 40,
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : AppColors.primary,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
