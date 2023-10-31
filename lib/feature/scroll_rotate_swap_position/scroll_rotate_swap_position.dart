import 'dart:ui';

import 'package:flutter/material.dart';

class ScrollRotateSwapPosition extends StatelessWidget {
  const ScrollRotateSwapPosition({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverPersistentHeader(
            delegate: CustomSliver(
              expandedHeight: 300,
              size: size,
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              height: size.height,
              color: Colors.red,
            ),
          ),
          const SliverToBoxAdapter(child: Placeholder()),
          const SliverToBoxAdapter(child: Placeholder()),
          const SliverToBoxAdapter(child: Placeholder()),
        ]),
      ),
    );
  }
}

class CustomSliver extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Size size;

  const CustomSliver({
    required this.expandedHeight,
    required this.size,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / expandedHeight;

    double angle;
    //gia tri tro lai
    double goBackRotate = 0.2;
    // speed rotate
    double speedRotate = 4.6;

    if (percent > goBackRotate) {
      // gia tri mau chot de tro lai
      double valueBack = 1 - 2 * goBackRotate;
      // gia tri de co the ve vi tri cu
      double valueEnd = 1 - valueBack;

      if (percent >= valueEnd) {
        angle = 0;
      } else {
        angle = (1 - percent - valueBack) * speedRotate;
      }
    } else {
      angle = percent * speedRotate;
    }

    return Stack(
      children: [
        Container(color: Colors.orange),
        if (percent > goBackRotate) ...[
          _Block(angle: angle),
          _BottomBlock(percent: percent),
        ] else ...[
          _BottomBlock(percent: percent),
          _Block(angle: angle),
        ]
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}

class _BottomBlock extends StatelessWidget {
  const _BottomBlock({
    required this.percent,
  });

  final double percent;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: null,
      left: 5 * lerpDouble(0, -30, percent)!,
      child: ClipPath(
        clipper: Rectangle(),
        child: Container(
          height: kToolbarHeight,
          color: Colors.white,
          child: Row(
            children: [
              const Expanded(child: SizedBox.shrink()),
              const Expanded(
                child: Text(
                  " aliqua excepteur culpa cupidatat qui aliquip pariatur nostrud velit proident.",
                ),
              ),
              Expanded(child: Container(color: Colors.blueAccent)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Block extends StatelessWidget {
  const _Block({
    required this.angle,
  });

  final double angle;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 40,
      child: Transform.rotate(
        alignment: Alignment.topRight,
        angle: angle,
        child: Container(
          width: 100,
          height: 100,
          color: Colors.blue,
          child: const Text(
            "data",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class Rectangle extends CustomClipper<Path> {
  // @override
  // void paint(Canvas canvas, Size size) {
  //   final path = Path();
  //   path.move(0, size.height);
  //   path.lineTo(50, 0);
  //   path.lineTo(size.width, 0);
  //   path.lineTo(size.width, size.height);
  //   canvas.clipPath(path);
  // }

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(100, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

// class CustomClip extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, 0);
//     path.quadraticBezierTo(size.width / 2, size.height * 2, size.width, 0);
//     path.lineTo(size.width, 0);
//     path.quadraticBezierTo(
//         size.width / 2, 2 * size.height - (size.width / 40), 0, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => true;
// }
