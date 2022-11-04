import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit/presentation/screens/home/home_page_mobile.dart';

void main() {
  setUp(() {});
  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }

  testWidgets('testing post testing', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text("This is a post"), findsWidgets);
  });
  testWidgets('testing only one app bar testing', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(AppBar), findsOneWidget);
  });
  testWidgets('testing only one bottom navigation bar testing',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });

  testWidgets('testing only one drop down menu', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byKey(const Key('dropdown')), findsWidgets);
  });

  testWidgets('test tapping on the drop down menu',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.byKey(const Key('dropdown')));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byKey(const Key('popular-test')), findsWidgets);
  });
  testWidgets('test tapping on the popular item opens popular page',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.byKey(const Key('dropdown')));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.tap(find.byKey(const Key('popular-test')).last);
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byKey(const Key('row-card')), findsWidgets);
  });

  testWidgets('test tapping on the profile image, end drawer opens',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.byKey(const Key('user-icon')));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(Drawer), findsWidgets);
  });
}
