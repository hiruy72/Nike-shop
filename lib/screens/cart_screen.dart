import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shop/app.dart';
import 'package:shop/core/theme/app_colors.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/widgets/cart_item_tile.dart';
import 'package:shop/widgets/primary_button.dart';
import 'package:shop/widgets/shop_app_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final cart = context.watch<CartProvider>();
    final lines = cart.lines;

    return Scaffold(
      appBar: ShopLogoAppBar(
        showBack: true,
        showCart: false,
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pushNamed(context, ShopApp.bookmarksRoute),
            child: Text(
              'SEE BOOKMARK LIST',
              style: theme.labelSmall?.copyWith(
                color: AppColors.secondaryText,
                decoration: TextDecoration.underline,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Bag',
                  style: theme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${cart.itemCount} Items',
                  style: theme.bodyMedium?.copyWith(
                    color: AppColors.secondaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(height: 1),
              ],
            ),
          ),
          if (lines.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              child: Row(
                children: [
                  Icon(
                    Icons.swipe_left,
                    size: 16,
                    color: AppColors.secondaryText.withValues(alpha: 0.7),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Swipe left to delete',
                    style: theme.bodySmall?.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: lines.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 56,
                          color: AppColors.secondaryText.withValues(alpha: 0.4),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Your bag is empty',
                          style: theme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        OutlinedButton(
                          onPressed: () => Navigator.popUntil(
                            context,
                            (route) => route.isFirst,
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: const BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 12,
                            ),
                          ),
                          child: const Text('Continue shopping'),
                        ),
                      ],
                    ),
                  )
                : SlidableAutoCloseBehavior(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: lines.length,
                      itemBuilder: (context, index) {
                        final line = lines[index];
                        return Slidable(
                          key: ValueKey(line.id),
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            extentRatio: 0.2,
                            children: [
                              SlidableAction(
                                onPressed: (_) => cart.remove(line.id),
                                backgroundColor: AppColors.accent,
                                foregroundColor: Colors.white,
                                icon: Icons.delete_outline,
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ],
                          ),
                          child: CartItemTile(line: line),
                        );
                      },
                    ),
                  ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: AppColors.divider),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Total',
                        style: theme.titleMedium?.copyWith(
                          color: AppColors.secondaryText,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${cart.subtotal.toStringAsFixed(2)}',
                        style: theme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    label: 'Checkout',
                    onPressed: lines.isEmpty
                        ? () {}
                        : () => Navigator.pushNamed(
                              context,
                              ShopApp.checkoutRoute,
                            ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
