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
          const SizedBox(height: 20),

          // Text styled avec extensions
          "Hello *world* #flutter"
              .text()
              .withBold(
                onTap: (i, t) {
                  print("Bold tapped: $t");
                },
              )
              .withPadding(16),

          // TextEditingController
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: "Search items",
            ).mergeWith(InputDecoration(border: OutlineInputBorder())),
          ).withPadding(16),

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

          const SizedBox(height: 20),

          // Boutons d'action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              "Show Alert"
                  .styledText(TS.col(Colors.white).bg("#000".color))
                  .withPadding(12)
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
                  .withPadding(8)
                  .expanded(),

              "Random Date"
                  .text()
                  .styled(TS.bg("#24A".color))
                  .withPadding(12)
                  .onTap(() {
                    final date = DateTime.now().subtract(5.durD);
                    context.snack("Date 5 days ago: ${date.format()}");
                  })
                  .withPadding(8)
                  .expanded(),
            ],
          ).withPadding(16),

          // Exemple de ExtNum et ExtDuration
          "Countdown:".styledText(TS.bold.size(18)).withPadding(16),
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
          ).withPadding(16),
        ],
      ),
    );
  }
}
