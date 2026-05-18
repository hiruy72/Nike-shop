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
      appBar: ShopTitledAppBar(
        title: 'My Bag',
        rightLabel: 'SEE BOOKMARK LIST',
        onRightTap: () => Navigator.pushNamed(context, ShopApp.bookmarksRoute),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${cart.itemCount} Items',
                style: theme.bodyMedium?.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
            ),
          ),
          Expanded(
            child: lines.isEmpty
                ? Center(
                    child: Text(
                      'Your bag is empty',
                      style: theme.bodyLarge?.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: lines.length,
                    itemBuilder: (context, index) {
                      final line = lines[index];
                      return Slidable(
                        key: ValueKey(line.id),
                        endActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          extentRatio: 0.22,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Total',
                      style: theme.bodyLarge?.copyWith(
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
        ],
      ),
    );
  }
}
