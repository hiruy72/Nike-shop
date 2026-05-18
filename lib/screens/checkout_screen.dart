import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/theme/app_colors.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/widgets/primary_button.dart';
import 'package:shop/widgets/product_image.dart';
import 'package:shop/widgets/shop_app_bar.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _orderPlaced = false;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _placeOrder(CartProvider cart) {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _orderPlaced = true);
    cart.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final cart = context.watch<CartProvider>();

    if (_orderPlaced) {
      return Scaffold(
        appBar: const ShopTitledAppBar(
          title: 'Order confirmed',
          showBack: false,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  size: 72,
                  color: AppColors.success,
                ),
                const SizedBox(height: 24),
                Text(
                  'Order placed!',
                  style: theme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Order #NK-${DateTime.now().millisecondsSinceEpoch % 100000}',
                  style: theme.bodyLarge?.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  label: 'Back to Shop',
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (cart.lines.isEmpty) {
      return Scaffold(
        appBar: const ShopTitledAppBar(title: 'Checkout'),
        body: Center(
          child: Text(
            'Your bag is empty',
            style: theme.bodyLarge?.copyWith(color: AppColors.secondaryText),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: const ShopTitledAppBar(title: 'Checkout'),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            Text(
              'Order summary',
              style: theme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            ...cart.lines.map((line) {
              final imageUrl = line.product.images.isNotEmpty
                  ? line.product.images.first
                  : null;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    SizedBox(
                      width: 56,
                      height: 56,
                      child: ProductImage(imageUrl: imageUrl),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            line.product.name,
                            style: theme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Size ${line.size} · Qty ${line.quantity}',
                            style: theme.bodySmall?.copyWith(
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '\$${line.lineTotal.toStringAsFixed(2)}',
                      style: theme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const Divider(height: 32),
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
            const SizedBox(height: 28),
            Text(
              'Shipping details',
              style: theme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nameController,
              decoration: _inputDecoration('Full name'),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Enter your name' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _addressController,
              decoration: _inputDecoration('Address'),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Enter your address' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _cityController,
              decoration: _inputDecoration('City'),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Enter your city' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phoneController,
              decoration: _inputDecoration('Phone'),
              keyboardType: TextInputType.phone,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Enter your phone' : null,
            ),
            const SizedBox(height: 24),
            Text(
              'Payment',
              style: theme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.credit_card, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Text(
                    'Card ending in 4242',
                    style: theme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            PrimaryButton(
              label: 'Place Order',
              onPressed: () => _placeOrder(cart),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColors.cardBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}
