import 'package:flutter/material.dart';
import 'package:shop/widgets/cart_bag_button.dart';
import 'package:shop/widgets/nike_logo.dart';

/// Centered Nike swoosh; optional back; cart bag or custom actions on the right.
class ShopLogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShopLogoAppBar({
    super.key,
    this.showBack = false,
    this.showCart = true,
    this.actions,
  });

  final bool showBack;
  final bool showCart;
  final List<Widget>? actions;

  static const double _sideWidth = 72;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final rightActions = actions ??
        (showCart
            ? const [
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: CartBagButton(),
                ),
              ]
            : const [SizedBox(width: 16)]);

    return AppBar(
      centerTitle: true,
      title: const NikeLogo(height: 22),
      leadingWidth: _sideWidth,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              onPressed: () => Navigator.maybePop(context),
            )
          : const SizedBox(width: _sideWidth),
      actions: rightActions,
    );
  }
}
