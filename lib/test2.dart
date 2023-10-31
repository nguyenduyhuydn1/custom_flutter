import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final ValueNotifier<bool> move = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: move,
            builder: (context, value, child) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                left: value ? -size.width + 100 : 0,
                child: Row(
                  children: [
                    Container(
                      width: size.width - 100,
                      height: size.height,
                      color: Colors.blue,
                    ),
                    GestureDetector(
                      onTap: () {
                        move.value = !move.value;
                      },
                      child: Container(
                        width: 100,
                        height: size.height,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
