import 'package:flutter_test/flutter_test.dart';
import 'package:smart_hydroponic/app.dart';

void main() {
  testWidgets('Welcome screen shows brand and Login CTA', (tester) async {
    await tester.pumpWidget(const SmartHydroponicApp());

    expect(find.text('Smart'), findsOneWidget);
    expect(find.text('Hydroponic'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
