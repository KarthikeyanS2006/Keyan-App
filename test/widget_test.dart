import 'package:flutter_test/flutter_test.dart';
import 'package:keyanapp/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PortfolioApp());

    // Verify that the app starts.
    expect(find.text("Contact Me"), findsNothing); // Should be on home screen/intro initially
  });
}
