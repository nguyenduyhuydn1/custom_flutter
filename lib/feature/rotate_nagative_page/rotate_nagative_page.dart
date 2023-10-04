import 'dart:math';

import 'package:flutter/material.dart';

class RotateNagativePage extends StatefulWidget {
  const RotateNagativePage({super.key});

  @override
  State<RotateNagativePage> createState() => _RotateNagativePageState();
}

class _RotateNagativePageState extends State<RotateNagativePage> {
  late PageController pageController;

  double percent = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    pageController.addListener(() {
      percent = pageController.page!;
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 200),
            SizedBox(
              height: size.height * 0.4,
              child: PageView.builder(
                controller: pageController,
                itemBuilder: (context, index) {
                  final percentBetween2Index = index - percent;
                  // final deg =
                  //     (lerpDouble(0.0, 50, percentBetween2Index)! * pi) / 180.0;
                  final deg = (65.0 * percentBetween2Index * pi) / 180;
                  // final deg = 0.8 * percentBetween2Index;
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.003)
                            ..rotateY(deg),
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            width: 300,
                            height: 200,
                            color: Colors.red,
                            child: const Center(child: Text("data")),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
