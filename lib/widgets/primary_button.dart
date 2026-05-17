import 'package:flutter/material.dart';
import 'package:shop/core/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.expanded = true,
  });

  final String label;
  final VoidCallback onPressed;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );

    if (!expanded) return button;
    return SizedBox(width: double.infinity, child: button);
  }
}

class OutlineIconButton extends StatelessWidget {
  const OutlineIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.isActive = false,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardBackground,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 56,
          height: 56,
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: isActive ? AppColors.accent : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
