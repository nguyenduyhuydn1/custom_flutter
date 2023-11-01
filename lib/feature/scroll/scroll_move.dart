import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ScrollMove extends StatelessWidget {
  const ScrollMove({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: CustomSliverAppBarDelegate(
                maxExtent: 400,
                minExtent: 100,
                builder: (percent) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: lerpDouble(100, 0, percent),
                          left: lerpDouble(150, 30, percent),
                          width: lerpDouble(100, 60, percent),
                          height: lerpDouble(100, 60, percent),
                          child: Transform(
                            transform: Matrix4.identity()
                              ..rotateZ(2 * pi * -percent),
                            alignment: Alignment.center,
                            child: Container(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Positioned(
                          top: lerpDouble(100, 0, percent),
                          left: 0,
                          width: lerpDouble(100, 60, percent),
                          height: lerpDouble(100, 60, percent),
                          child: Container(
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(child: Placeholder()),
            const SliverToBoxAdapter(child: Placeholder()),
            const SliverToBoxAdapter(child: Placeholder()),
            const SliverToBoxAdapter(child: Placeholder()),
          ],
        ),
      ),
    );
  }
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double _maxExtent;
  final double _minExtent;
  final Widget Function(double percent) builder;

  const CustomSliverAppBarDelegate({
    required double maxExtent,
    required double minExtent,
    required this.builder,
  })  : _maxExtent = maxExtent,
        _minExtent = minExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(shrinkOffset / _maxExtent);
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
// https://www.youtube.com/watch?v=bEHPCwjLdno
