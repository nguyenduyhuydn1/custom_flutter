import 'dart:ui';

import 'package:flutter/material.dart';

class AnimationScale extends StatefulWidget {
  const AnimationScale({super.key});

  @override
  State<AnimationScale> createState() => _AnimationScaleState();
}

const double _maxHeight = 300.0;
const double _minHeight = 60;
const double _menuWidth = 220.0;

class _AnimationScaleState extends State<AnimationScale>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _expanded = false;
  double _currentHeight = _maxHeight;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: _expanded
                  ? (details) {
                      final newHeight = _currentHeight - details.delta.dy;
                      _controller.value = _currentHeight / _maxHeight;
                      _currentHeight = newHeight.clamp(_minHeight, _maxHeight);
                    }
                  : null,
              onVerticalDragEnd: _expanded
                  ? (details) {
                      if (_currentHeight < _maxHeight / 2) {
                        _currentHeight = _maxHeight;
                        _controller.reverse();
                        _expanded = false;
                      } else {
                        _expanded = true;
                        _controller.forward(from: _currentHeight / _maxHeight);
                        _currentHeight = _maxHeight;
                      }
                      setState(() {});
                    }
                  : null,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final value =
                      Curves.elasticInOut.transform(_controller.value);
                  return Stack(
                    children: [
                      Positioned(
                        height: lerpDouble(_minHeight, _maxHeight, value),
                        width: lerpDouble(_menuWidth, size.width, value),
                        bottom: lerpDouble(40.0, 0.0, value),
                        left: lerpDouble(
                            size.width / 2 - _menuWidth / 2, 0, value),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(
                                lerpDouble(20.0, 20.0, value)!,
                              ),
                              bottom: Radius.circular(
                                lerpDouble(20.0, 0.0, value)!,
                              ),
                            ),
                            color: Colors.red.shade200,
                          ),
                          child: FittedBox(
                            // SingleChildScrollView
                            fit: BoxFit.scaleDown,
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.black,
                                  width: 100,
                                  height: 100,
                                ),
                                const Text("data2"),
                                const Text("data3"),
                                const Text("data4"),
                                const Text("data5"),
                                const Text("data6"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        height: _minHeight,
                        left: size.width / 2 - _menuWidth / 2,
                        width: _menuWidth,
                        bottom: 40,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _expanded = !_expanded;
                            });
                            if (_expanded) {
                              _controller.forward();
                            } else {
                              _controller.reverse();
                            }

                            // _expanded = true;
                            // _currentHeight = _maxHeight;
                            // _controller.forward(from: 0.0);
                            // setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue.shade200,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.search),
                                Icon(Icons.search),
                                Icon(Icons.search),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // AnimatedPositioned(
                      //   duration: const Duration(milliseconds: 300),
                      //   height: check ? 220 : 60,
                      //   left: check ? 0 : 100,
                      //   right: check ? 0 : 100,
                      //   bottom: check ? 0 : 20,
                      //   curve: Curves.linear,
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       setState(() {
                      //         check = !check;
                      //       });
                      //     },
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //         borderRadius: check
                      //             ? const BorderRadius.vertical(
                      //                 top: Radius.circular(20),
                      //               )
                      //             : BorderRadius.circular(10),
                      //         color: Colors.amber,
                      //       ),
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.end,
                      //         children: [
                      //           Container(
                      //             width: 220,
                      //             height: 60,
                      //             decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(10),
                      //               color: Colors.red,
                      //             ),
                      //             child: const Row(
                      //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //               children: [
                      //                 Icon(Icons.search),
                      //                 Icon(Icons.search),
                      //                 Icon(Icons.search),
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // )
                      // TweenAnimationBuilder(
                      //   duration: const Duration(milliseconds: 1000),
                      //   tween: Tween(begin: 0.0, end: 1.0),
                      //   curve: Curves.bounceOut,
                      //   builder: (context, value, child) {
                      //     return Transform.translate(
                      //       offset: Offset(50, 100 * value),
                      //       child: child!,
                      //     );
                      //   },
                      //   child: Container(
                      //     color: Colors.blue,
                      //     height: 100,
                      //     width: double.infinity,
                      //   ),
                      // ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
