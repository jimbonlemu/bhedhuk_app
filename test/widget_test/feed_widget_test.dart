import 'package:feed_me/widgets/icon_title_widget.dart';
import 'package:feed_me/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

List<dynamic> sampleItemMenuWidget = ["Extrajoss", "Kratingdaeng", "Kukubima"];
void main() {
  group("Test feed widgets", () {

    testWidgets("MenuWidget has a Title and Object to List",
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MenuWidget(
            title: "Our Drinks",
            objectToList: sampleItemMenuWidget,
          ),
        ),
      ));
      final titleFinder = find.text("Our Drinks");
      final listFinder = find.text("- Extrajoss\n- Kratingdaeng\n- Kukubima");

      expect(titleFinder, findsOneWidget);
      expect(listFinder, findsOneWidget);
    });
    testWidgets("IconTitleWidget has a Title and Icon", (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: IconTitleWidget(
            icon: Icons.abc,
            text: "aaa",
          ),
        ),
      ));
      final iconFinder = find.byIcon(Icons.abc);
      final textFinder = find.text("aaa");
      expect(iconFinder, findsOneWidget);
      expect(textFinder, findsOneWidget);
    });
  });
}
