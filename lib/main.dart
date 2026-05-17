import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app.dart';
import 'package:shop/providers/bookmark_provider.dart';
import 'package:shop/providers/cart_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
      ],
      child: const ShopApp(),
    ),
  );
}
