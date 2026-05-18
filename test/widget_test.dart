import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shop/app.dart';
import 'package:shop/providers/bookmark_provider.dart';
import 'package:shop/providers/cart_provider.dart';

void main() {
  testWidgets('App loads home with gender filters and category dropdown',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => BookmarkProvider()),
        ],
        child: const ShopApp(),
      ),
    );

    expect(find.text('New Arrivals'), findsOneWidget);
    expect(find.text('Men'), findsOneWidget);
    expect(find.text('Women'), findsOneWidget);
    expect(find.text('Kids'), findsOneWidget);
    expect(find.text('Category'), findsOneWidget);
  });
}
