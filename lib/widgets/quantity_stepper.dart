import 'package:flutter/material.dart';
import 'package:shop/core/theme/app_colors.dart';

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepButton(icon: Icons.remove, onTap: onDecrement, isAccent: false),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            '$quantity',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        _StepButton(icon: Icons.add, onTap: onIncrement, isAccent: true),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.onTap,
    required this.isAccent,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool isAccent;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isAccent ? AppColors.accent : AppColors.cardBackground,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 32,
          height: 32,
          child: Icon(
            icon,
            size: 18,
            color: isAccent ? Colors.white : AppColors.secondaryText,
          ),
        ),
      ),
    );
  }
}
