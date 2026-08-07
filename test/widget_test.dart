import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_hydroponic/app.dart';

void main() {
  testWidgets('Welcome shows logo, gap layout, and green Login button', (
    tester,
  ) async {
    await tester.pumpWidget(const SmartHydroponicApp());

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName ==
                'assets/images/welcome.png',
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName ==
                'assets/images/logo-hydro.png',
      ),
      findsOneWidget,
    );
    expect(find.byKey(const Key('welcome_login_button')), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
