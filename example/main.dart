import 'package:flutter/material.dart';
import 'package:flutter_extended/flutter_extended.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Extended Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();
  final List<String> items = ["Apple", "Banana", "Cherry", "Date", "Fig"];
  bool showList = true;

  int counter = 0;

  @override
  void initState() {
    super.initState();

    // Débounce sur le text controller
    controller.debounce((text) {
      print("Debounced text: $text");
      setState(() {
        showList = text.isNotBlank;
      });
    }, const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Extended Demo")),
      body: sliverScrollView(
        children: [
          20.gap,

          "$counter"
              .animatedText(
                style: TS.bold.size(32).col(Colors.blue),
                duration: const Duration(milliseconds: 500),
              )
              .center(),

          20.gap,
          ElevatedButton(
            onPressed: () {
              setState(() {
                counter++;
              });
            },
            child: const Text("Increment Counter"),
          ).center(),
          20.gap,
          // Text styled avec extensions
          "Hello *world* #flutter"
              .text()
              .withBold(
                onTap: (i, t) {
                  print("Bold tapped: $t");
                },
              )
              .withPadding(all: 16),

          // TextEditingController
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: "Search items",
            ).mergeWith(InputDecoration(border: OutlineInputBorder())),
          ).withPadding(all: 16),

          // Liste filtrée
          ...items.searchText(controller.text).mapIndexed((i, item) {
            return ListTile(
              title: item.text().styled(TS.medium.size(16)),
              subtitle: "Length: ${item.length}".text(),
              trailing: Icon(Icons.arrow_forward).onTap(() {
                context.snack("Tapped $item");
              }),
            );
          }),

          20.gap,

          // Boutons d'action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              "Show Alert"
                  .styledText(TS.col(Colors.white).bg("#000".color))
                  .withPadding(all: 12)
                  .onTap(() {
                    showDialog(
                      context: context,
                      builder:
                          (_) => ExtendedAlertDialog(
                            title: "Confirm",
                            message: "Do you want to continue?",
                            onConfirm: () => context.snack("Confirmed!"),
                            onCancel: () => context.snack("Cancelled!"),
                          ),
                    );
                  })
                  .withPadding(all: 8)
                  .expanded(),

              "Random Date"
                  .text()
                  .styled(TS.bg("#24A".color))
                  .withPadding(all: 12)
                  .onTap(() {
                    final date = DateTime.now().subtract(5.durD);
                    context.snack("Date 5 days ago: ${date.format()}");
                  })
                  .withPadding(all: 8)
                  .expanded(),
            ],
          ).withPadding(all: 16),

          // Exemple de ExtNum et ExtDuration
          "Countdown:".styledText(TS.bold.size(18)).withPadding(all: 16),
          FutureBuilder(
            future: 5.durS.wait().then((_) => "Done"),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator().center();
              }
              return snapshot.data
                  .toString()
                  .styledText(TS.col(blue).size(20))
                  .center();
            },
          ).withPadding(all: 16),
        ],
      ),
    );
  }
}
