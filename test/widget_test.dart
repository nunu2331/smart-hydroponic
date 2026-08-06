import 'package:flutter_test/flutter_test.dart';
import 'package:smart_hydroponic/app.dart';

void main() {
  testWidgets('Welcome placeholder shows Login CTA', (tester) async {
    await tester.pumpWidget(const SmartHydroponicApp());

    expect(find.textContaining('Smart Hydroponic'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
