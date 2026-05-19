import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/theme/app_colors.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/widgets/order_success_view.dart';
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
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();
  bool _orderPlaced = false;
  bool _summaryExpanded = true;
  String _delivery = 'standard';
  String? _orderId;
  int _orderItemCount = 0;
  double _orderTotal = 0;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  void _placeOrder(CartProvider cart) {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _orderId = 'Order #NK-${DateTime.now().millisecondsSinceEpoch % 100000}';
      _orderItemCount = cart.itemCount;
      _orderTotal = cart.subtotal;
      _orderPlaced = true;
    });
    cart.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final cart = context.watch<CartProvider>();

    if (_orderPlaced) {
      return Scaffold(
        appBar: const ShopLogoAppBar(showBack: false, showCart: false),
        body: OrderSuccessView(
          orderId: _orderId ?? '',
          itemCount: _orderItemCount,
          totalPaid: _orderTotal,
          onBackToShop: () =>
              Navigator.popUntil(context, (route) => route.isFirst),
        ),
      );
    }

    if (cart.lines.isEmpty) {
      return Scaffold(
        appBar: const ShopLogoAppBar(showBack: true, showCart: false),
        body: Center(
          child: Text(
            'Your bag is empty',
            style: theme.bodyLarge?.copyWith(color: AppColors.secondaryText),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: const ShopLogoAppBar(showBack: true, showCart: false),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                children: [
                  Text(
                    'Checkout',
                    style: theme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Complete your order below',
                    style: theme.bodyMedium?.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _StepIndicator(activeStep: 0),
                  const SizedBox(height: 20),
                  _OrderSummaryCard(
                    cart: cart,
                    expanded: _summaryExpanded,
                    onToggle: () =>
                        setState(() => _summaryExpanded = !_summaryExpanded),
                  ),
                  const SizedBox(height: 20),
                  _SectionCard(
                    title: 'Contact',
                    icon: Icons.person_outline,
                    child: Column(
                      children: [
                        _LabeledField(
                          label: 'Full name',
                          controller: _nameController,
                          icon: Icons.badge_outlined,
                          validator: _required('your name'),
                        ),
                        const SizedBox(height: 14),
                        _LabeledField(
                          label: 'Email',
                          controller: _emailController,
                          icon: Icons.email_outlined,
                          keyboard: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Enter your email';
                            }
                            if (!v.contains('@')) return 'Enter a valid email';
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        _LabeledField(
                          label: 'Phone',
                          controller: _phoneController,
                          icon: Icons.phone_outlined,
                          keyboard: TextInputType.phone,
                          validator: _required('your phone'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _SectionCard(
                    title: 'Shipping address',
                    icon: Icons.local_shipping_outlined,
                    child: Column(
                      children: [
                        _LabeledField(
                          label: 'Street address',
                          controller: _addressController,
                          icon: Icons.home_outlined,
                          validator: _required('your address'),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: _LabeledField(
                                label: 'City',
                                controller: _cityController,
                                icon: Icons.location_city_outlined,
                                validator: _required('your city'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _LabeledField(
                                label: 'ZIP',
                                controller: _zipController,
                                icon: Icons.pin_outlined,
                                keyboard: TextInputType.number,
                                validator: _required('ZIP code'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Delivery',
                          style: theme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _DeliveryOption(
                                label: 'Standard',
                                subtitle: 'Free · 3–5 days',
                                selected: _delivery == 'standard',
                                onTap: () =>
                                    setState(() => _delivery = 'standard'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _DeliveryOption(
                                label: 'Express',
                                subtitle: '\$15 · 1–2 days',
                                selected: _delivery == 'express',
                                onTap: () =>
                                    setState(() => _delivery = 'express'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _SectionCard(
                    title: 'Payment',
                    icon: Icons.lock_outline,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary,
                                AppColors.primary.withValues(alpha: 0.85),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.credit_card,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'VISA',
                                    style: theme.titleMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '•••• •••• •••• 4242',
                                style: theme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Demo card · no charge',
                                style: theme.bodySmall?.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.divider)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
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
                    const SizedBox(height: 14),
                    PrimaryButton(
                      label: 'Place Order',
                      onPressed: () => _placeOrder(cart),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? Function(String?) _required(String field) {
    return (v) =>
        v == null || v.trim().isEmpty ? 'Enter $field' : null;
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.activeStep});

  final int activeStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StepDot(label: 'Shipping', index: 0, active: activeStep >= 0),
        Expanded(child: Container(height: 2, color: AppColors.divider)),
        _StepDot(label: 'Payment', index: 1, active: activeStep >= 1),
      ],
    );
  }
}

class _StepDot extends StatelessWidget {
  const _StepDot({
    required this.label,
    required this.index,
    required this.active,
  });

  final String label;
  final int index;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: active ? AppColors.accent : AppColors.cardBackground,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '${index + 1}',
            style: theme.labelMedium?.copyWith(
              color: active ? Colors.white : AppColors.secondaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: theme.labelSmall?.copyWith(
            color: active ? AppColors.primary : AppColors.secondaryText,
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _OrderSummaryCard extends StatelessWidget {
  const _OrderSummaryCard({
    required this.cart,
    required this.expanded,
    required this.onToggle,
  });

  final CartProvider cart;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    'Order summary (${cart.itemCount})',
                    style: theme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    expanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.secondaryText,
                  ),
                ],
              ),
            ),
          ),
          if (expanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: cart.lines.map((line) {
                  final imageUrl = line.product.images.isNotEmpty
                      ? line.product.images.first
                      : null;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 48,
                            height: 48,
                            child: ProductImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                line.product.name,
                                style: theme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
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
                          style: theme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 22, color: AppColors.accent),
              const SizedBox(width: 10),
              Text(
                title,
                style: theme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.controller,
    required this.icon,
    this.keyboard,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryText,
              ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboard,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 20, color: AppColors.secondaryText),
            filled: true,
            fillColor: AppColors.cardBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class _DeliveryOption extends StatelessWidget {
  const _DeliveryOption({
    required this.label,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Material(
      color: selected
          ? AppColors.accent.withValues(alpha: 0.1)
          : AppColors.cardBackground,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? AppColors.accent : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                subtitle,
                style: theme.bodySmall?.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
