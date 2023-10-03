import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class M3 {
  final bool isSelected;
  final Color color;

  M3({required this.isSelected, required this.color});

  M3 copyWith({
    Color? color,
    bool? isSelected,
  }) =>
      M3(
        color: color ?? this.color,
        isSelected: isSelected ?? this.isSelected,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is M3 &&
          runtimeType == other.runtimeType &&
          isSelected == other.isSelected &&
          color == other.color;

  @override
  int get hashCode => Object.hash(color, isSelected);

  // int get hashCode => color.hashCode ^ isSelected.hashCode;
}

class AnimationScroll3D extends StatefulWidget {
  const AnimationScroll3D({super.key});

  @override
  State<AnimationScroll3D> createState() => _AnimationScroll3DState();
}

class _AnimationScroll3DState extends State<AnimationScroll3D>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _goToDetailsController;

  late Animation _animation;
  late Animation _gotoDetailsAnimation;

  List<M3> dataM3 = [
    M3(isSelected: false, color: Colors.red),
    M3(isSelected: false, color: Colors.blue),
    M3(isSelected: false, color: Colors.green),
    M3(isSelected: false, color: Colors.amber),
  ];

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 1.0, curve: Curves.bounceOut),
    ));

    _goToDetailsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _gotoDetailsAnimation = CurvedAnimation(
      parent: _goToDetailsController,
      curve: const Interval(0.0, 1.0, curve: Curves.linear),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _goToDetailsController.dispose();

    super.dispose();
  }

  bool checkTranslate = false;
  int _selectedIndex = 0;

  int getCurrentFactor(int currentIndex) {
    if (currentIndex == _selectedIndex) {
      return 0;
    } else if (currentIndex > _selectedIndex) {
      return -1;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.grey,
            height: size.height * 0.6,
            child: Stack(children: [
              ...List.generate(dataM3.length, (index) {
                final item = dataM3[index];

                return AnimatedBuilder(
                    animation: Listenable.merge([
                      _animation,
                      _gotoDetailsAnimation,
                    ]),
                    builder: (context, _) {
                      final double top = lerpDouble(
                          index * -70.0, 0.0, 1.0 - _animation.value)!;

                      final deg =
                          (lerpDouble(0.0, 25, _animation.value)! * pi) / 180.0;

                      return Positioned.fill(
                        top: top,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.003)
                            ..translate(
                              0.0,
                              getCurrentFactor(index) *
                                  _gotoDetailsAnimation.value *
                                  size.height,
                            )
                            ..rotateX(deg),
                          child: Center(
                            child: GestureDetector(
                              onTap: () async {
                                if (!checkTranslate) {
                                  setState(() {
                                    checkTranslate = true;
                                  });
                                  _animationController.forward();
                                } else {
                                  // dataM3 = dataM3.map((v) {
                                  //   return item == v
                                  //       ? v.copyWith(isSelected: true)
                                  //       : v.copyWith(isSelected: false);
                                  // }).toList();
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                  _goToDetailsController.forward();

                                  const Duration duration =
                                      Duration(milliseconds: 800);
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration: duration,
                                      reverseTransitionDuration: duration,
                                      pageBuilder: (context, animation, _) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: _Details(
                                            index: index,
                                            item: item,
                                            onPressed: () {
                                              Navigator.pop(context);
                                              _goToDetailsController.reverse();
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                              child: Hero(
                                tag: "tag$index",
                                child: _Item(item: item),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }).reversed.toList(),
            ]),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                checkTranslate = false;
              });
              _animationController.reverse(from: 0.3);
            },
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}

class _Details extends StatelessWidget {
  final M3 item;
  final int index;
  final VoidCallback? onPressed;
  const _Details({
    required this.item,
    required this.index,
    this.onPressed,
  });

  Widget _flightShuttleBuilder(
      Animation<double> animation, HeroFlightDirection flightDirection) {
    final isPop = flightDirection == HeroFlightDirection.pop;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        // final value = isPop
        //     ? Curves.easeInBack.transform(animation.value)
        //     : Curves.easeOutBack.transform(animation.value);

        final value = isPop
            ? Curves.linear.transform(animation.value)
            : Curves.decelerate.transform(animation.value);

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..rotateX(4 * pi * value),
          child: child,
        );
      },
      child: _Item(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("test"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: onPressed,
        ),
      ),
      body: Center(
        child: Hero(
          tag: "tag$index",
          flightShuttleBuilder: (_, animation, flightDirection, __, ___) {
            return _flightShuttleBuilder(animation, flightDirection);
          },
          child: _Item(item: item),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.item,
  });

  final M3 item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: item.color,
      child: Align(
        alignment: Alignment.topCenter,
        child: Image.network('https://picsum.photos/seed/picsum/200/300'),
      ),
    );
  }
}
