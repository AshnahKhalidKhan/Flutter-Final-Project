import 'package:flutter/material.dart';
import 'package:flutter_final_project/reusable_widgets_constants/app_bar.dart';
import 'package:flutter_final_project/reusable_widgets_constants/drawer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() 
{
  testWidgets('MyAppBar widget test', (WidgetTester tester) async 
  {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

    await tester.pumpWidget
    (
      MaterialApp
      (
        home: Scaffold
        (
          key: scaffoldKey,
          appBar: const MyAppBar
          (
            pagename: 'Testing MyAppBar',
          ),
        ),
      ),
    );

    expect(find.text('Testing MyAppBar'), findsOneWidget);
  });
}
