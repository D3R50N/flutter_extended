# Flutter Extended

Flutter Extended is a collection of Dart extensions and helper widgets designed to simplify Flutter development.

## Why Use Flutter Extended ?

Flutter and Dart are awesome, but boring because of lack of useful methods or extensions.

Why do I have to write so much code just to add style to a text or create a row or column?
Why can't we truncate a string natively or remove accent? Why isn't there a simple way to navigate inside our apps? Why do we have to write boilerplate code to handle null-safety, or make widgets interactive without creating new classes?  

**Flutter Extended answers these questions with clean, chainable extensions:**

```Dart

// instead of 
Navigator.of(context).push(...blabla);
// just do 
context.goTo(MyPage()); // replaceTo, allTo, back, backTo, ...

"https:myapp.com/link".openUrl(); //open the url in external app
"A very long text".trunc(10); // "A very ..."
"Héllo World".noAccent; // "Hello World"

// You have to do all of this
await Future.delayed(Duration(seconds:10));
// ..when you can just
await 10.durS.wait(); // See also durMs,durMin, etc..

print(value.isFalsy); // return true if value is null, 0, false, blank string, empty list or map

// Why this
Padding(
  padding: const EdgeInsets.all(8.0),
  child: Center(
    child: GestureDetector(
      onTap: () {
        print("Tapped");
      },
      child: Text(
        "Tap me",
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.red,
          backgroundColor: Colors.black,
        ),
      ),
    ),
  ),
),
// .. when you can do this
"Tap me"
.styledText(TS.w700.col(red).bg(black), overflow: TextOverflow.ellipsis)
.onTap(() => print("Tapped"))
.center()
.withPadding(all: 8);


3.14159.roundTo(2); // 3.14 (natively you have to parse result of .toStringAsFixed)
3.0.value // 3 (if the decimal is .0, why can't just show the int)

//Why can't you just pick a random element from an iterable
final x= [1,2,3].random();

// Why shuffling a list will mutate it
final s=[1,2,3];
final s1=s.shuffled; // doesn't affect s
final s2=s.shuffled; // not same as s1

// ...And many other things that make flutter and dart sweet to use
```

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_extended: ^latest
```

Then run `flutter pub get` to install the package.
Import the package in your Dart files:

```dart
import 'package:flutter_extended/flutter_extended.dart';
```

## Examples

See the [Documentation](https://pub.dev/documentation/flutter_extended/latest/) for detailed usage examples and API reference.

```dart
import 'package:flutter_extended/flutter_extended.dart';

void main() {
  // ---- ExtNum ----
  print(5.0.value); // 5
  print(3.14159.roundTo(2)); // 3.14
  print(10.durS.fromNow()); // DateTime 10 seconds from now
  print(1500.formatCompact()); // "1.5K"
  print(25.percentOf(100)); // 25.0
  final spaceV = 16.h; // SizedBox(height: 16)
  final spaceH = 16.w; // SizedBox(width: 16)
  final padding = 16.allPadding; // EdgeInsets.all(16)

  // ---- ExtDate ----
  final now = DateTime.now();
  print(now.isToday); // true
  print(now.isYesterday); // false
  print(now.isTomorrow); // false
  print(now.isPast); // false
  print(now.isFuture); // false
  print(now.isWeekend); // true / false
  print(DateTime(1995, 5, 20).age); // age in years
  print(now.addDays(7)); // 7 days later
  print(now.startOfDay); // today at 00:00:00
  print(now.endOfDay); // today at 23:59:59

  // ---- ExtString ----
  final str = "Héllo #Flutter *world*";
  print(str.noAccent); // Hello #Flutter *world*
  print(str.asSlug); // hello-flutter-world
  print("https://google.com".isUrl); // true
  print("user@mail.com".isEmail); // true
  print("+33612345678".isPhone); // true
  print("John Doe".initials); // "JD"
  print("123456789".mask(start: 2, end: 7)); // "12*****89"
  print("123".toIntOrNull); // 123
  print("abc".toIntOrNull); // null
  print("hello world".toTitleCase); // "Hello World"
  print("hello_world".toCamelCase); // "helloWorld"
  print("helloWorld".toSnakeCase); // "hello_world"
  await "Copied text".copyToClipboard(); // copies to clipboard

  // ---- ExtList ----
  final list = ["apple", "banana", "cherry", 'ananas'];
  print(list.searchText("ana")); // ['ananas','banana'] ananas comes first cause it's the best match
  print(list.toSentence(maxToShow: 2)); // "apple, banana & 2 others"
  print(list.shuffled);
  print(list.random());
  print([1, 2, 3, 4, 5].chunk(2)); // [[1, 2], [3, 4], [5]]
  print([1, 2, 3].average()); // 2.0
  final separatedWidgets = [Text("A"), Text("B")].separated(10.w);

  // ---- ExtMap ----
  final map = {"a": 1, "b": 2};
  print(map.has("a")); // true
  print(map.string("b")); // "2"
  print(map.getOr("c", 0)); // 0

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
  final widget = Text("Click me")
      .onTap(() => print("Tapped"))
      .hero("heroTag")
      .tooltip("Tap to trigger")
      .shimmer(isLoading: true)
      .card()
      .unfocusOnTap()
      .expandedIf(true)
      .center()
      .container(
        color: Colors.yellow,
        padding: EdgeInsets.all(8),
      );
  final textWidget = "Hello".text(align: TextAlign.center);
  final animatedText = "$myCounter".animatedText(
    style: TS.w600.size(20).col(blue),
    duration: 2.durS,
    fade: false,
  ); // changes text with animation when myCounter changes

  // ---- ExtContext (inside build method) ----
  // context.theme, context.primaryColor, context.backgroundColor
  // context.colorScheme, context.textTheme
  // context.isDarkMode, context.isKeyboardOpen
  // context.isPortrait, context.isLandscape
  // context.isMobile, context.isTablet, context.isDesktop
  // final cols = context.responsive(mobile: 1, tablet: 2, desktop: 4);
  // context.goTo(MyPage()), context.snack("Message")
  // context.showModalSheet(MyBottomSheet())
  // context.unfocus()

  // ---- StyledText ----
  final st = StyledText("Hello Flutter", TS.w500.size(16));
  final st2 = "Hello Flutter".styledText(TS.bold);
  final st3 = "Message".text().styled(TS.w700.bg(red));

  // ---- ExtGlobalKey ----
  final key = GlobalKey();
  // key.size, key.globalOffset ... would be used in a real widget tree

  // ---- ExtStream ----
  final stream = Stream.value(1).merge(Stream.value(2));
  stream.listen(print); // 1, 2

  // ---- ExtText (Text extensions) ----
  Text("Hello *bold*").withBold();

  // --- Colors -----
  final dangerColor = red; // black, white, and many others are already defined
  final blackHex = "#000".color;
  final myColor = "#FF0957".color;
  final darkerRed = red.darken(0.2);
  final lighterBlue = blue.lighten(0.2);
  final hexStr = red.toHex(); // "#ff0000"

  // ---- Helper widgets ----
  final empty = shrink; // const SizedBox.shrink()

  // ---- Debug flag & debug print ----
  FlutterExtended.debugFlag = "MY_APP";
  "User created".debug("Auth"); // prints: [MY_APP][Auth] User created

  print("Done");
}
```
