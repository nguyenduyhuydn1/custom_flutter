import 'dart:math';
import 'dart:ui';

import 'package:custom_flutter/feature/boats/model/models.dart';
import 'package:flutter/material.dart';

class Boats extends StatefulWidget {
  const Boats({super.key});

  @override
  State<Boats> createState() => _BoatsState();
}

class _BoatsState extends State<Boats> {
  late PageController _pageController;
  int _currentIndex = 0;
  bool check = false;
  double _percent = 0.0;

  @override
  void initState() {
    _pageController = PageController(
      viewportFraction: 0.7,
      initialPage: _currentIndex,
    );

    _pageController.addListener(pageViewListener);
    super.initState();
  }

  void handleCheck() {
    setState(() {
      check = !check;
    });
  }

  void pageViewListener() {
    _currentIndex = _pageController.page!.floor();
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
                    child: GestureDetector(
                      onTap: () {
                        const Duration duration = Duration(milliseconds: 600);
                        handleCheck();

                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            // pop page
                            reverseTransitionDuration: duration,
                            // push page
                            transitionDuration: duration,
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return FadeTransition(
                                opacity: animation,
                                child: Details(
                                  currentIndex: _currentIndex,
                                  percent: percentBetween2Index,
                                  onPressed: handleCheck,
                                  item: item,
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: Hero(
                        tag: "tag$index",
                        child: Image.asset(item.image),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

class Details extends StatefulWidget {
  final int currentIndex;
  final double percent;
  final VoidCallback onPressed;
  final Boat item;

  const Details({
    super.key,
    required this.currentIndex,
    required this.percent,
    required this.onPressed,
    required this.item,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final rotate = pi * -0.5;
  final double dx = 80.0;
  final double dy = -100;
  bool checkDetails = false;

  Widget _flightShuttleBuilder(
      Animation<double> animation, HeroFlightDirection flightDirection) {
    final isPop = flightDirection == HeroFlightDirection.pop;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final value = isPop
            ? Curves.easeInBack.transform(animation.value)
            : Curves.easeOutBack.transform(animation.value);
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..translate(dx * value, dy * value, 0)
            ..rotateZ(rotate * value),
          child: child,
        );
      },
      child: _Image(widget: widget),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  checkDetails = true;
                });
                widget.onPressed();
                Navigator.pop(context);
              },
              child: Hero(
                tag: 'tag${widget.currentIndex}',
                flightShuttleBuilder: (_, animation, flightDirection, __, ___) {
                  return _flightShuttleBuilder(animation, flightDirection);
                },
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..translate(dx, dy, 0)
                    ..rotateZ(rotate),
                  child: _Image(widget: widget),
                ),
              ),
            ),
            const Spacer(),
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 1000),
              tween: Tween(
                  begin: checkDetails ? 0.0 : 1.0,
                  end: checkDetails ? 1.0 : 0.0),
              curve: Curves.fastOutSlowIn,
              builder: (context, value, child) {
                return Opacity(
                  opacity: 1 - value,
                  child: Transform.translate(
                    offset: Offset(0, 100 * value),
                    child: child!,
                  ),
                );
              },
              child: Container(
                height: size.height * 0.3,
                width: size.width,
                color: Colors.red,
                child: const Center(
                  child: Text("data"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.widget,
  });

  final Details widget;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      widget.item.image,
      height: 410,
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
// https://www.youtube.com/watch?v=EEx2gSJFAPk