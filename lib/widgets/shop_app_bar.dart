import 'package:flutter/material.dart';
import 'package:shop/core/theme/app_colors.dart';
import 'package:shop/widgets/cart_bag_button.dart';
import 'package:shop/widgets/nike_logo.dart';

/// Logo header: back (optional) | Nike swoosh | black bag pill.
class ShopLogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShopLogoAppBar({super.key, this.showBack = false});

  final bool showBack;

  static const double _sideWidth = 72;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const NikeLogo(),
      leadingWidth: _sideWidth,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              onPressed: () => Navigator.maybePop(context),
            )
          : const SizedBox(width: _sideWidth),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: CartBagButton(),
        ),
        SizedBox(width: 4),
      ],
    );
  }
}

/// Title header: back | bold title | optional right action (no bag icon).
class ShopTitledAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShopTitledAppBar({
    super.key,
    required this.title,
    this.rightLabel,
    this.onRightTap,
    this.showBack = true,
  });

  final String title;
  final String? rightLabel;
  final VoidCallback? onRightTap;
  final bool showBack;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return AppBar(
      centerTitle: true,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              onPressed: () => Navigator.maybePop(context),
            )
          : null,
      automaticallyImplyLeading: showBack,
      title: Text(
        title,
        style: theme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
      ),
      actions: [
        if (rightLabel != null && onRightTap != null)
          TextButton(
            onPressed: onRightTap,
            child: Text(
              rightLabel!,
              style: theme.labelSmall?.copyWith(
                color: AppColors.secondaryText,
                decoration: TextDecoration.underline,
                letterSpacing: 0.5,
              ),
            ),
          )
        else
          const SizedBox(width: 16),
      ],
    );
  }
}
