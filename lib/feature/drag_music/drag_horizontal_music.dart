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
  final List<Icon> listIcon = [
    const Icon(Icons.home, size: 30),
    const Icon(Icons.cloud, size: 30),
    const Icon(Icons.headphones, size: 30),
    const Icon(Icons.calendar_month, size: 30),
  ];

  double lerp(double min, double max) =>
      lerpDouble(min, max, _controller.value)!;

  // ValueNotifier<List<double>> listOffsetDy = ValueNotifier([]);
  int currentIndex = 0;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _opacity = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
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
              // -145 do
              // final deg = (-145.0 * pi) / 180;
              final widthBgHome = size.width + 200;
              final centerPosWithHeightWidth =
                  (size.width / 2) - (widthBgHome / 2);

              return Stack(fit: StackFit.expand, children: [
                //main image
                Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      imageAssets,
                      fit: BoxFit.cover,
                      alignment: Alignment(lerp(0.0, 2.0), 0),
                    ),
                    Positioned(
                      top: -200.0,
                      left: lerp(centerPosWithHeightWidth,
                          centerPosWithHeightWidth - 60),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..rotateZ((-45 * pi) / 180)
                          ..translate(
                            lerpDouble(-85.0, 0, _moveDown.value),
                            lerpDouble(0.0, -120.0, _moveDown.value)!,
                          ),
                        // ..translate(
                        //   lerpDouble(-85.0, 124, _moveDown.value),
                        //   0.0,
                        // ),
                        child: Container(
                          height: 50,
                          width: widthBgHome,
                          color: const Color.fromARGB(255, 167, 182, 239),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -127,
                      left: lerp(centerPosWithHeightWidth,
                          centerPosWithHeightWidth - 60),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..rotateZ((-45 * pi) / 180)
                          ..translate(
                            lerpDouble(-65.0, 0, _moveDown.value),
                            lerpDouble(0.0, -120.0, _moveDown.value)!,
                          ),
                        child: Container(
                          height: 60,
                          width: widthBgHome,
                          color: const Color.fromARGB(218, 255, 255, 255),
                        ),
                      ),
                    ),

                    // center 1 widget trong positioned
                    // (size.width / 2) - ((size.width + 200) / 2)
                    Positioned(
                      bottom: -65,
                      right: lerp(centerPosWithHeightWidth,
                          centerPosWithHeightWidth + 60),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..rotateZ((-45 * pi) / 180)
                          ..translate(
                            35.0,
                            lerpDouble(0.0, 250.0, _moveDown.value)!,
                          ),
                        child: SizedBox(
                          height: 250,
                          width: widthBgHome,
                          child: Column(
                            children: [
                              Container(
                                color: const Color.fromARGB(68, 0, 0, 0),
                                height: 60,
                                width: widthBgHome,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(
                                        Icons.search,
                                        size: 35,
                                        color:
                                            Color.fromARGB(216, 255, 255, 255),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 35,
                                        color:
                                            Color.fromARGB(216, 255, 255, 255),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(
                                        Icons.messenger_outline,
                                        size: 35,
                                        color:
                                            Color.fromARGB(216, 255, 255, 255),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(
                                        Icons.phone_android_outlined,
                                        size: 35,
                                        color:
                                            Color.fromARGB(216, 255, 255, 255),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 250 - 60,
                                color: const Color.fromARGB(255, 173, 186, 242),
                                child: const Column(
                                  children: [
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Positioned(
                    //   bottom: 0,
                    //   right: lerp(widthNav, widthNav + 60),
                    //   child: CustomPaint(
                    //     foregroundPainter: TriangleClipper(),
                    //     child: SizedBox(
                    //       height: size.width - widthNav - 40,
                    //       width: size.width - widthNav - 40,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),

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
                                    const SizedBox(
                                      child: Column(children: [
                                        SizedBox(height: 20),
                                        CircleAvatar(
                                          child: Icon(Icons.person_2),
                                        ),
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
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 50,
                                      ),
                                      child: Stack(
                                        children: [
                                          Opacity(
                                            opacity: lerp(0.0, 1.0),
                                            child: const Column(children: [
                                              SizedBox(height: 100),
                                              Icon(
                                                Icons.cloud,
                                                size: 50,
                                                color: Colors.white,
                                              ),
                                              SizedBox(height: 10),
                                              Icon(
                                                Icons
                                                    .pause_presentation_outlined,
                                                size: 50,
                                                color: Colors.white,
                                              ),
                                            ]),
                                          ),
                                          Opacity(
                                            opacity: lerp(1.0, 0.0),
                                            child: TweenAnimationBuilder(
                                                tween: Tween(
                                                  begin: 70.0 * currentIndex,
                                                  end: 70.0 * currentIndex,
                                                ),
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                builder:
                                                    (context, value, child) {
                                                  return CustomPaint(
                                                    foregroundPainter: DrawLine(
                                                      dy1: value + 25,
                                                      dy2: value + 45,
                                                      totalHeight:
                                                          70.0 * currentIndex,
                                                    ),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          ...List.generate(
                                                              listIcon.length,
                                                              (index) {
                                                            final item =
                                                                listIcon[index];
                                                            return GestureDetector(
                                                              onTap: () {
                                                                if (index ==
                                                                    1) {
                                                                  _move
                                                                      .forward();
                                                                } else {
                                                                  _move
                                                                      .reverse();
                                                                }
                                                                setState(() {
                                                                  currentIndex =
                                                                      index;
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  vertical: 20,
                                                                ),
                                                                child: item,
                                                              ),
                                                            );
                                                          }),
                                                        ]),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    )
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
  }) : super();
  // }) : _dy1 = dy1;

  final double dy1;
  final double dy2;
  final double totalHeight;

  @override
  void paint(Canvas canvas, Size size) {
    double a = dy2 / (totalHeight + 45);

    if (dy2 < (totalHeight + 45)) {
      a = dy2 / (totalHeight + 45);
    }
    if (dy2 >= (totalHeight + 45)) {
      a = (totalHeight + 45) / dy2;
    }

    final paint = Paint()
      ..strokeWidth = 4
      ..color = Color.fromARGB(lerpDouble(0, 255, a)!.toInt(), 85, 108, 126);

    final p1 = Offset(45, dy1);
    final p2 = Offset(45, dy2);

    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(DrawLine oldDelegate) => oldDelegate.dy1 != dy1;
}

class TriangleClipper extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color.fromARGB(255, 173, 186, 242);
    // final paint = Paint();
    final h = size.height;
    final w = size.width;

    final path = Path()
      ..moveTo(0, h)
      ..lineTo(w, 0)
      ..lineTo(w, h);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
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
