import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:FlutterGalleryApp/screens/feed_screen.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Hero test', (WidgetTester tester) async {
    final GlobalKey key = GlobalKey();

    await tester.pumpWidget(
      MaterialApp(
        key: key,
        home: FullScreenImage(
          photo: kFlutterDash,
          altDescription: 'This is Flutter dash. I love him :)',
          userName: 'kaparray',
          name: 'Kirill Adeshchenko',
          userPhoto: 'https://skill-branch.ru/img/speakers/Adechenko.jpg',
          heroTag: 'tag',
        ),
      ),
    );

    final Hero topModalBarrier = tester.widget<Hero>(
      find.byType(Hero),
    );

    expect(topModalBarrier.tag, 'tag');
    expect(true, topModalBarrier.child.runtimeType == Photo);
  });

  testWidgets('AnimatedBuilder', (WidgetTester tester) async {
    final GlobalKey keyUserAvatar = GlobalKey();

    await tester.pumpWidget(
      MaterialApp(
        key: keyUserAvatar,
        home: FullScreenImage(
          photo: kFlutterDash,
          altDescription: 'This is Flutter dash. I love him :)',
          userName: 'kaparray',
          name: 'Kirill Adeshchenko',
          userPhoto: 'https://skill-branch.ru/img/speakers/Adechenko.jpg',
          heroTag: 'tag',
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 300));
    double oneFifth = _getOpacity(keyUserAvatar, tester, false);
    expect(0.7, (oneFifth * 10).roundToDouble() / 10);

    await tester.pump(const Duration(milliseconds: 800));
    double full = _getOpacity(keyUserAvatar, tester, false);
    expect(1.0, (full * 10).roundToDouble() / 10);

    final keyName = GlobalKey();

    await tester.pumpWidget(
      MaterialApp(
        key: keyName,
        home: FullScreenImage(
          photo: kFlutterDash,
          altDescription: 'This is Flutter dash. I love him :)',
          userName: 'kaparray',
          name: 'Kirill Adeshchenko',
          userPhoto: 'https://skill-branch.ru/img/speakers/Adechenko.jpg',
          heroTag: 'tag',
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 800));
    double test1 = _getOpacity(keyName, tester, true);
    expect(0.1, (test1 * 10).roundToDouble() / 10);

    await tester.pump(const Duration(milliseconds: 1200));
    double test2 = _getOpacity(keyName, tester, true);
    expect(1.0, (test2 * 10).roundToDouble() / 10);
  });
}

double _getOpacity(GlobalKey key, WidgetTester tester, bool isLast) {
  bool isFadeTransition = false;

  Finder finder = find.byType(Opacity);

  if (tester.widgetList(finder).toList().isEmpty) {
    finder = find.byType(FadeTransition);
    isFadeTransition = true;
  }

  if (isFadeTransition) {
    final FadeTransition transition =
        tester.widgetList(finder).toList()[isLast ? 4 : 2];
    return transition.opacity.value;
  } else {
    final Opacity transition =
        tester.widgetList(finder).toList()[isLast ? 1 : 0];
    return transition.opacity;
  }
}
