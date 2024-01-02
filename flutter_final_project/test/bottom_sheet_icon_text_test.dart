import 'package:flutter/material.dart';
import 'package:flutter_final_project/reusable_widgets_constants/bottom_sheet_icon_text_info.dart';
import 'package:flutter_final_project/reusable_widgets_constants/list_tile_icon_text_info.dart';
import 'package:flutter_test/flutter_test.dart';

void main() 
{
  testWidgets('BottomSheetIconTextInfo widget test', (WidgetTester tester) async 
  {
    await tester.pumpWidget
    (
      MaterialApp
      (
        home: Scaffold
        (
          body: BottomSheetIconTextInfo
          (
            icon: Icons.info,
            info: 'Test Info',
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.info), findsOneWidget);
    expect(find.text('Test Info'), findsOneWidget);
  });
}
