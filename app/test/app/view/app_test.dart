import 'package:flutter_test/flutter_test.dart';
import 'package:peristock/app/app.dart';
import 'package:peristock/products/products.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(ProductsListView), findsOneWidget);
    });
  });
}
