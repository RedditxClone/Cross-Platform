// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:reddit/data/model/auth_model.dart';
// import 'package:reddit/presentation/screens/home/home_page_web.dart';

// void main() {
//   setUp(() {});
//   Widget createWidgetUnderTest() {
//     return MaterialApp(
//       home: HomePageWeb(),
//     );
//   }

//   // testing when logged in
//   // testing that there is only one app bar
//   testWidgets('testing only one app bar', (WidgetTester tester) async {
//     await tester.pumpWidget(createWidgetUnderTest());
//     expect(find.byType(AppBar), findsOneWidget);
//   });

//   // testing that there is only one drop down menu to navigate between home and popular
//   testWidgets('testing only one drop down menu', (WidgetTester tester) async {
//     await tester.pumpWidget(createWidgetUnderTest());
//     expect(find.byKey(const Key('dropdown')), findsOneWidget);
//   });
// // testing finding search bar
//   testWidgets('testing finding search bar', (WidgetTester tester) async {
//     await tester.pumpWidget(createWidgetUnderTest());
//     expect(find.byKey(const Key('search-bar')), findsOneWidget);
//   });
//   // testing tapping on the drop down menu and navigate to the popular page
//   testWidgets('test tapping on the drop down menu',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(createWidgetUnderTest());
//     await tester.tap(find.byKey(const Key('dropdown')));
//     await tester.pump(const Duration(milliseconds: 500));
//     expect(find.byKey(const Key('popular-test')), findsWidgets);
//   });
//   // testing navigate to user settings from drop down menu
//   testWidgets('testing navigate to user settings from drop down menu',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(createWidgetUnderTest());
//     await tester.tap(find.byKey(const Key('popup-menu')));
//     await tester.pump(const Duration(milliseconds: 500));
//     expect(find.byKey(const Key('loggout')), findsOneWidget);
//   });
// }
