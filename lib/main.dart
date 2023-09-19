import 'package:flutter/material.dart';

import 'package:custom_flutter/dragg_able_scrollable_sheet/index.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Builder(
            builder: (context) => FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const CustomDraggableScrollableSheet(),
                  ),
                );
              },
              child: const Text("data"),
            ),
          ),
        ),
      ),
    );
  }
}
