import 'package:flutter/material.dart';
import 'package:shop/core/theme/app_theme.dart';
import 'package:shop/screens/bookmark_list_screen.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/checkout_screen.dart';
import 'package:shop/screens/app_start_screen.dart';
import 'package:shop/screens/home_screen.dart';
import 'package:shop/screens/product_detail_screen.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  static const String homeRoute = '/';
  static const String productRoute = '/product';
  static const String cartRoute = '/cart';
  static const String bookmarksRoute = '/bookmarks';
  static const String checkoutRoute = '/checkout';
  static const String onboardingRoute = '/onboarding';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nike Shop',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const AppStartScreen(),
      routes: {
        homeRoute: (_) => const HomeScreen(),
        onboardingRoute: (_) => const AppStartScreen(),
        cartRoute: (_) => const CartScreen(),
        bookmarksRoute: (_) => const BookmarkListScreen(),
        checkoutRoute: (_) => const CheckoutScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == productRoute) {
          final productId = settings.arguments as String?;
          if (productId == null) return null;
          return MaterialPageRoute(
            builder: (_) => ProductDetailScreen(productId: productId),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
