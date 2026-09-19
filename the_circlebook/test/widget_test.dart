import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:the_circlebook/app.dart';

class _TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() {
  setUpAll(() {
    HttpOverrides.global = _TestHttpOverrides();
  });

  testWidgets('The Circlebook app renders the main shell', (tester) async {
    await tester.pumpWidget(const TheCirclebookApp());

    expect(find.text('The Circlebook'), findsWidgets);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Discover'), findsOneWidget);
  });
}
