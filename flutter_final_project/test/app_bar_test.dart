import 'package:flutter/material.dart';
import 'package:flutter_final_project/reusable_widgets_constants/app_bar.dart';
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

    // Open the drawer using the ScaffoldState
    scaffoldKey.currentState!.openDrawer();
    await tester.pumpAndSettle(); // Wait for animations to complete

    // Verify that the drawer is open
    expect(find.byType(Drawer), findsOneWidget);

    // Add further verification as needed based on your app's drawer functionality
  });
}
