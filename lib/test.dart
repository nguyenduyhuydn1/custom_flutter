import 'dart:ui';

import 'package:custom_flutter/testModel/models.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late PageController _pageController;
  final int _currentIndex = 0;
  bool check = false;
  double _percent = 0.0;

  void handleCheck() {
    setState(() {
      check = !check;
    });
  }

  @override
  void initState() {
    _pageController = PageController(
      viewportFraction: 0.7,
      initialPage: _currentIndex,
    );

    _pageController.addListener(pageViewListener);
    super.initState();
  }

  void pageViewListener() {
    //animation huong doi

    // _currentIndex = _pageController.page!.floor();
    // _percent = (_pageController.page! - _currentIndex).abs();

    _percent = _pageController.page!;

    setState(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          _Appbar(check: check),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: Boat.listBoat.length,
              itemBuilder: (context, index) {
                final item = Boat.listBoat[index];
                //animation 2 huong
                // khi ta print index no se print 2 gia tri
                final percentBetween2Index = (_percent - index).abs();

                return Opacity(
                  opacity: (1 - percentBetween2Index).clamp(0, 1),
                  child: Transform.scale(
                    scale: lerpDouble(1.0, 0.7, percentBetween2Index),
                    child: Hero(
                      tag: "tag$index",
                      child: Image.asset(item.image),
                    ),
                  ),
                );
              },
            ),
          ),
          Builder(
            builder: (context) => FilledButton(
              onPressed: () {
                handleCheck();

                Navigator.push(
                  context,
                  PageRouteBuilder(
                    reverseTransitionDuration:
                        const Duration(milliseconds: 600),
                    transitionDuration: const Duration(milliseconds: 600),
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: Details(
                          currentIndex: _currentIndex,
                          percent: _percent,
                          onPressed: handleCheck,
                        ),
                      );
                    },
                  ),
                );
              },
              child: const Text("test page"),
            ),
          ),
          // Details(currentIndex: _currentIndex, percent: _percent)
        ]),
      ),
    );
  }
}

class Details extends StatelessWidget {
  final int currentIndex;
  final double percent;
  final VoidCallback onPressed;
  const Details({
    super.key,
    required this.currentIndex,
    required this.percent,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Hero(
                tag: 'tag',
                child: Image.asset(
                  'assets/coffee/1.png',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            FilledButton(
              onPressed: () {
                onPressed();
                Navigator.pop(context);
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}

class _Appbar extends StatelessWidget {
  final bool check;
  const _Appbar({required this.check});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
      transform: Matrix4.identity()..setTranslationRaw(0, check ? -100 : 0, 0),
      child: AnimatedOpacity(
        opacity: check ? 0 : 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 100,
          color: Colors.blue.shade200,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.home),
              Icon(Icons.search),
            ],
          ),
        ),
      ),
    );
  }
}
