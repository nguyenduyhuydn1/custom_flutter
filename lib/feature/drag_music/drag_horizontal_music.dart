import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class DragHorizontalMusic extends StatefulWidget {
  const DragHorizontalMusic({super.key});

  @override
  State<DragHorizontalMusic> createState() => _DragHorizontalMusicState();
}

class _DragHorizontalMusicState extends State<DragHorizontalMusic>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _opacity;
  late AnimationController _move;

  late Animation _moveDown;

  final String imageAssets = 'assets/drag_music/drag_music.jpg';
  final double widthNav = 90.0;
  final duration = const Duration(milliseconds: 300);

  final List<_ItemIcon> listIcon = [
    const _ItemIcon(icon: Icons.home),
    const _ItemIcon(icon: Icons.cloud),
    const _ItemIcon(icon: Icons.headphones),
    const _ItemIcon(icon: Icons.calendar_month),
  ];

  final List<IconData> iconsHome = [
    Icons.search,
    Icons.camera_alt_outlined,
    Icons.messenger_outline,
    Icons.phone_android_outlined,
  ];

  double lerp(double min, double max) =>
      lerpDouble(min, max, _controller.value)!;

  // ValueNotifier<List<double>> listOffsetDy = ValueNotifier([]);
  int currentIndex = 0;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );
    _opacity = AnimationController(
      vsync: this,
      duration: duration,
    );
    _move = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _moveDown = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _move,
      curve: Curves.decelerate,
    ));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _opacity.dispose();
    _move.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
            animation: Listenable.merge([_controller, _opacity, _moveDown]),
            builder: (context, child) {
              // center 1 widget trong positioned
              // (size.width / 2) - (widthBgHome / 2)
              // tinh middle tamgiac canh huyen ((size.width / 2) * 1 / (sqrt(2) / 2)) / 2
              //vao github de coi chi tiet

              // -45 do
              const deg = (-45 * pi) / 180;
              final widthBgHome = size.width + 200;

              // caculator right
              final centerPosWithHeightWidthRight =
                  ((size.width + widthNav) / 2) - (widthBgHome / 2);
              final centerPosWithHeightWidthLeft =
                  ((size.width - widthNav) / 2) - ((widthBgHome) / 2);

              // caculator move d
              final triangleFormula = 1 / (sqrt(2) / 2);
              final halfWidthNoNavBar = (size.width - widthNav) / 2;

              final hypotenuse = halfWidthNoNavBar * triangleFormula;

              final mh = sqrt(
                pow(hypotenuse / 2, 2) +
                    pow(halfWidthNoNavBar, 2) -
                    (halfWidthNoNavBar * hypotenuse * (sqrt(2) / 2)),
              );

              return Stack(fit: StackFit.expand, children: [
                //main image
                Stack(fit: StackFit.expand, children: [
                  Image.asset(
                    imageAssets,
                    fit: BoxFit.cover,
                    alignment: Alignment(lerp(0.0, 2.0), 0),
                  ),
                  Positioned(
                    top: 0,
                    left: lerp(centerPosWithHeightWidthLeft,
                        centerPosWithHeightWidthLeft - 60),
                    width: widthBgHome,
                    child: Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()
                        ..rotateZ(deg)
                        ..translate(
                          -hypotenuse / 2,
                          lerpDouble(-mh, -mh - 420, _moveDown.value)!,
                        ),
                      child: Column(children: [
                        Container(
                          height: 50,
                          color: const Color.fromARGB(255, 167, 182, 239),
                        ),
                        Container(
                          height: 60,
                          color: const Color.fromARGB(218, 255, 255, 255),
                        )
                      ]),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: lerp(centerPosWithHeightWidthRight,
                        centerPosWithHeightWidthRight + 60),
                    width: widthBgHome,
                    child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..rotateZ(deg)
                        ..translate(
                          hypotenuse / 2,
                          lerpDouble(mh, mh + 420, _moveDown.value)!,
                        ),
                      child: Column(children: [
                        Container(
                          color: const Color.fromARGB(68, 0, 0, 0),
                          height: 60,
                          width: widthBgHome,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(iconsHome.length, (index) {
                              final item = iconsHome[index];
                              return _ItemIcon(icon: item);
                            }),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 200,
                          color: const Color.fromARGB(255, 173, 186, 242),
                          child: const Column(children: [
                            SizedBox(height: 20),
                            Text(
                              "Monday",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: 35,
                              ),
                            ),
                            Text(
                              "Oct.12th",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w300,
                                fontSize: 25,
                              ),
                            ),
                          ]),
                        )
                      ]),
                    ),
                  )
                ]),

                //side image
                Positioned(
                  right: lerp(-size.width + widthNav, 0),
                  height: size.height,
                  width: size.width,
                  child: Stack(fit: StackFit.expand, children: [
                    Image.asset(
                      imageAssets,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      width: widthNav,
                      child: GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          _controller.value -=
                              details.primaryDelta! / size.width;
                          if (_controller.value > 0.3) {
                            _opacity.value -=
                                details.primaryDelta! / size.width;
                          } else {
                            if (details.primaryDelta! > 0) {
                              _opacity.value -=
                                  details.primaryDelta! / size.width + 0.015;
                            } else {
                              _opacity.value +=
                                  details.primaryDelta! / size.width;
                            }
                          }
                        },
                        onHorizontalDragEnd: (details) {
                          if (details.primaryVelocity! > 500 ||
                              _controller.value > 0.5) {
                            _opacity.forward();
                            _controller.forward();
                          }
                          if (details.primaryVelocity! < -500 ||
                              _controller.value < 0.5) {
                            _opacity.reverse();
                            _controller.reverse();
                          }
                        },
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(
                                        lerp(245, 235).toInt(), 224, 219, 236),
                                    Color.fromARGB(
                                        lerp(225, 125).toInt(), 224, 219, 236),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: const [0.2, 1.0],
                                ),
                              ),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Column(children: [
                                      CircleAvatar(child: Icon(Icons.person_2)),
                                      SizedBox(height: 50),
                                      _RotateBox(
                                        child: Text(
                                          "24:00",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 45,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      )
                                    ]),
                                    Stack(children: [
                                      Opacity(
                                        opacity: lerp(0.0, 1.0),
                                        child: const Column(children: [
                                          SizedBox(height: 100),
                                          _ItemIcon(
                                            icon: Icons.cloud,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 10),
                                          _ItemIcon(
                                            icon: Icons
                                                .pause_presentation_outlined,
                                            color: Colors.white,
                                          ),
                                        ]),
                                      ),
                                      Opacity(
                                        opacity: lerp(1.0, 0.0),
                                        child: TweenAnimationBuilder(
                                            tween: Tween(
                                              begin: 65.0 * currentIndex,
                                              end: 65.0 * currentIndex,
                                            ),
                                            duration: duration,
                                            builder: (context, value, child) {
                                              final dy1 = value + 23;
                                              final dy2 = value + 43;
                                              final totalHeight =
                                                  currentIndex * 65.0 + 43;

                                              return CustomPaint(
                                                foregroundPainter: DrawLine(
                                                  dy1: dy1,
                                                  dy2: dy2,
                                                  totalHeight: totalHeight,
                                                ),
                                                child: Column(
                                                  children: List.generate(
                                                      listIcon.length, (index) {
                                                    final item =
                                                        listIcon[index];
                                                    return GestureDetector(
                                                      onTap: () {
                                                        if (index == 1) {
                                                          _move.forward();
                                                        } else {
                                                          _move.reverse();
                                                        }
                                                        setState(() {
                                                          currentIndex = index;
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 15),
                                                        child: item,
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              );
                                            }),
                                      )
                                    ])
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // background side image
                    Positioned.fill(
                      left: widthNav,
                      child: Opacity(
                        opacity: lerpDouble(1.0, 0.0, _opacity.value)!,
                        child: Container(
                          color: const Color.fromARGB(202, 255, 255, 255),
                        ),
                      ),
                    )
                  ]),
                )
              ]);
            }),
      ),
    );
  }
}

class _ItemIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _ItemIcon({
    required this.icon,
    this.color = const Color.fromARGB(216, 255, 255, 255),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Icon(
        icon,
        size: 35,
        color: color,
      ),
    );
  }
}

class _RotateBox extends StatelessWidget {
  final Widget child;
  const _RotateBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(quarterTurns: 1, child: child);
  }
}

class DrawLine extends CustomPainter {
  const DrawLine({
    required this.dy2,
    required this.dy1,
    required this.totalHeight,
  });
  // }) : _dy1 = dy1;

  final double dy1;
  final double dy2;
  final double totalHeight;

  @override
  void paint(Canvas canvas, Size size) {
    double a = dy2 / totalHeight;

    if (dy2 < totalHeight) {
      a = dy2 / totalHeight;
    }
    if (dy2 >= totalHeight) {
      a = totalHeight / dy2;
    }

    final paint = Paint()
      ..strokeWidth = 4
      ..color = Color.fromARGB(lerpDouble(0, 255, a)!.toInt(), 85, 108, 126);

    final p1 = Offset(70, dy1);
    final p2 = Offset(70, dy2);

    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(DrawLine oldDelegate) => oldDelegate.dy1 != dy1;
}

// class TriangleClipper extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = const Color.fromARGB(255, 173, 186, 242);
//     // final paint = Paint();
//     final h = size.height;
//     final w = size.width;

//     final path = Path()
//       ..moveTo(0, h)
//       ..lineTo(w, 0)
//       ..lineTo(w, h);
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// class TriangleClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.moveTo(0, size.height);
//     path.lineTo(size.width, 0);
//     path.lineTo(size.width, size.height);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(TriangleClipper oldClipper) => true;
// }
