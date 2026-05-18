import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/data/mock_data.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_filter_state.dart';
import 'package:shop/providers/bookmark_provider.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/screens/home_screen.dart';
import 'package:shop/utils/product_filter_logic.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({'onboarding_complete': true});
  });

  testWidgets('Home shows filter bar and product grid', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => BookmarkProvider()),
        ],
        child: const MaterialApp(home: HomeScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('New Arrivals'), findsOneWidget);
    expect(find.text('Filters'), findsOneWidget);
    expect(find.text('Men'), findsOneWidget);
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  test('ProductFilterLogic filters by gender', () {
    final men = ProductFilterLogic.apply(
      products,
      const ProductFilterState(gender: ProductGender.men),
    );
    expect(men.every((p) => p.gender == ProductGender.men), isTrue);
    expect(men.length, lessThan(products.length));
  });
}
