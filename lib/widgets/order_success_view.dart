import 'package:flutter/material.dart';
import 'package:shop/core/theme/app_colors.dart';
import 'package:shop/widgets/primary_button.dart';

class OrderSuccessView extends StatelessWidget {
  const OrderSuccessView({
    super.key,
    required this.orderId,
    required this.itemCount,
    required this.totalPaid,
    required this.onBackToShop,
  });

  final String orderId;
  final int itemCount;
  final double totalPaid;
  final VoidCallback onBackToShop;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              size: 52,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Thank you!',
            style: theme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            orderId,
            style: theme.titleSmall?.copyWith(
              color: AppColors.secondaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "We'll send a confirmation shortly.",
            textAlign: TextAlign.center,
            style: theme.bodyLarge?.copyWith(
              color: AppColors.secondaryText,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 28),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _SummaryRow(
                  label: 'Items',
                  value: '$itemCount',
                  theme: theme,
                ),
                const SizedBox(height: 12),
                _SummaryRow(
                  label: 'Total paid',
                  value: '\$${totalPaid.toStringAsFixed(2)}',
                  theme: theme,
                  bold: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            label: 'Back to Shop',
            onPressed: onBackToShop,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    required this.theme,
    this.bold = false,
  });

  final String label;
  final String value;
  final TextTheme theme;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: theme.bodyMedium?.copyWith(color: AppColors.secondaryText),
        ),
        const Spacer(),
        Text(
          value,
          style: (bold ? theme.titleMedium : theme.bodyLarge)?.copyWith(
            fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
