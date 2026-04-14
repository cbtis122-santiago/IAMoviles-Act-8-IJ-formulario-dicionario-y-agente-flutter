import 'package:flutter_test/flutter_test.dart';

import 'package:act7formulario/main.dart';

void main() {
  testWidgets('App start smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app name exists in the UI
    expect(find.textContaining('ANTIGRAVITY'), findsOneWidget);
  });
}
