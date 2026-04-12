// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_extended/flutter_extended.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';

void main() {
  test('Tests extensions', () {
    exp(dynamic v, dynamic e) {
      debugPrint('Expecting: $v == $e');
      expect(v, e);
    }

    exp('hello'.random(), isIn('hello'));
    exp(Duration(days: 2, seconds: 65).format, '02:00:01:05');
    exp(['max', 1, 'ok', 'max', 1, 2].toUnique(), ['max', 1, 'ok', 2]);

    exp(5.gap, isA<Gap>());
    exp("2023-10-05".toDate(), isA<DateTime>());
    exp(10.0.value, 10);
    exp(10.5.value, 10.5);
    exp(5.isInInterval(1, 10), true);
    exp(5.isInInterval(5, 10, excludeA: true), false);
    exp([1, 2, 3].toSentence(), "1, 2 & 3");
    exp([1, 2, 3].toSentence(maxToShow: 2), "1, 2 & 1 others");
    exp([1, 2, 3].toSentence(maxToShow: 1), "1 & 2 others");
    exp([1, 2, 3].toSentence(maxToShow: 0), "");
    exp(
      [1, 2, 3].toSentence(separator: ";", lastSeparator: "and"),
      "1; 2 and 3",
    );
    exp([1, 2, 3].toSentence(suffix: "more"), "1, 2 & 3");
    exp([].toSentence(), "");
    exp([42].toSentence(), "42");
    exp([42].toSentence(maxToShow: 0), "");
    exp([42].toSentence(maxToShow: -1), "");
    exp([42].toSentence(maxToShow: -5), "");
    exp([42].toSentence(maxToShow: null), "42");
    exp(false.isFalsy, true);
    exp(true.isTruthy, true);
    exp(0.isFalsy, true);
    exp("   ".isNotBlank, false);
    exp(Duration(seconds: 1).formatHHMMSS, "00:00:01");
    exp(4.isIn([3, 4, 5]), true);
    exp({"hello": "world"}.has("hello"), true);
  });

  test("All ext", () {
    print("A very long text".trunc(10));
    // ---- ExtNum ----
    print(5.v); // 5
    print(3.14159.roundTo(2)); // 3.14
    print(10.durS.fromNow()); // DateTime 10 seconds from now

    // ---- ExtString ----
    final str = "Héllo #Flutter *world*";
    print(str.noAccent); // Hello #Flutter *world*
    print(str.asSlug); // hello-flutter-world
    print("https://google.com".isUrl); // true

    // ---- ExtList ----
    final list = ["apple", "banana", "cherry", 'ananas'];
    print(list.searchText("ana")); // ['ananas','banana']
    print(list.toSentence(maxToShow: 2)); // "apple & banana 1 others"
    print(list.shuffled);
    print(list.random());

    // ---- ExtMap ----
    final map = {"a": 1, "b": 2};
    print(map.has("a")); // true
    print(map.string("b")); // "2"

    // ---- ExtBool / ExtFalsy ----
    bool? maybe;
    print(maybe.orFalse); // false
    print("".isFalsy); // true

    // ---- ExtFuture ----
    Future.value(42).retry(3).then(print); // 42

    // ---- ExtDuration ----
    final duration = 65.durS;
    print(duration.formatMMSS); // 01:05
    duration.wait().then((_) => print("Waited 65 seconds"));

    // ---- ExtTextController ----
    final controller = TextEditingController(text: "12/12/2025");
    print(controller.toDate()); // DateTime(2025, 12, 12)

    // ---- ExtTextStyle ----
    final style = TS.bold.italic.size(18).col(Colors.blue);
    print(style.fontWeight); // FontWeight.w700

    // ---- ExtWidget ----
    final widget = Text("Click me").onTap(() => print("Tapped")).center();

    // ---- StyledText ----
    final st = StyledText("Hello Flutter", TS.w500.size(16));

    // ---- ExtGlobalKey ----
    final key = GlobalKey();
    // key.size, key.globalOffset ... would be used in a real widget tree

    // ---- ExtStream ----
    final stream = Stream.value(1).merge(Stream.value(2));
    stream.listen(print); // 1, 2

    // ---- ExtText (Text extensions) ----
    Text("Hello *bold*").withBold();

    print("Done");
  });
}
