// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:reddit/data/model/auth_model.dart';
// import 'package:reddit/data/model/post_model.dart';
// import 'package:reddit/data/model/posts/posts_model.dart';
// import 'package:reddit/presentation/screens/home/home_page_mobile.dart';
// import 'package:reddit/presentation/widgets/posts/posts_web.dart';

// late User? user;
// PostsModel post = PostsModel.fromJson({
//   'subredditId': '',
//   'title': '',
//   'text': '',
//   'nsfw': '',
//   'spoiler': false,
//   'flair': false,
//   'publishedDate': '',
// });
// void main() {
//   setUp(() {
//     user = null;

//     Widget createWidgetUnderTest() {
//       return MaterialApp(
//         home: HomePage(),
//       );
//     }

//     // testing that the post cards exist
//     testWidgets('testing post testing', (WidgetTester tester) async {
//       await tester.pumpWidget(createWidgetUnderTest());
//       expect(find.byWidget(PostsWeb(postsModel: posts)), findsWidgets);
//     });

//     // testing that there is only one bottom nav bar
//     testWidgets('testing only one bottom navigation bar',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(createWidgetUnderTest());
//       expect(find.byType(BottomNavigationBar), findsOneWidget);
//     });

//     // testing that there is only one drop down menu to navigate between home and popular
//     testWidgets('testing only one drop down menu', (WidgetTester tester) async {
//       await tester.pumpWidget(createWidgetUnderTest());
//       expect(find.byKey(const Key('dropdown')), findsOneWidget);
//     });

//     // testing tapping on the drop down menu and find the popular page
//     testWidgets('test tapping on the drop down menu',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(createWidgetUnderTest());
//       await tester.tap(find.byKey(const Key('dropdown')));
//       await tester.pump(const Duration(milliseconds: 500));
//       expect(find.byKey(const Key('popular-test')), findsWidgets);
//     });
//     // testing tapping on the popular page drop down menu item navigates to popular page
//     testWidgets('test tapping on the popular item opens popular page',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(createWidgetUnderTest());
//       await tester.tap(find.byKey(const Key('dropdown')));
//       await tester.pump(const Duration(milliseconds: 500));
//       await tester.tap(find.byKey(const Key('popular-test')).last);
//       await tester.pump(const Duration(milliseconds: 500));
//       expect(find.byKey(const Key('row-card')), findsWidgets);
//     });

//     testWidgets('test tapping on the profile image, end drawer opens',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(createWidgetUnderTest());
//       await tester.tap(find.byKey(const Key('user-icon')));
//       await tester.pump(const Duration(milliseconds: 500));
//       expect(find.byType(Drawer), findsWidgets);
//     });
//   });
// }
