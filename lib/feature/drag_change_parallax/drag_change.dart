import 'dart:ui';

import 'package:flutter/material.dart';

class DragChange extends StatefulWidget {
  const DragChange({super.key});

  @override
  State<DragChange> createState() => _DragChangeState();
}

const double minHeight = 120;

class _DragChangeState extends State<DragChange>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double get maxHeight => MediaQuery.of(context).size.height;

  double lerp(double min, double max) =>
      lerpDouble(min, max, _controller.value)!;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    super.initState();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta! / maxHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned.fill(
                  top: null,
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      _handleDragUpdate(details);
                    },
                    child: Container(
                      height: lerp(minHeight, maxHeight),
                      color: Colors.red,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
