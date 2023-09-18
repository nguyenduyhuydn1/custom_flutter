import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Builder(
            builder: (context) => FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AnimationNavbar(),
                  ),
                );
              },
              child: const Text("data"),
            ),
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class AnimationNavbar extends StatefulWidget {
  const AnimationNavbar({
    super.key,
  });

  @override
  State<AnimationNavbar> createState() => _AnimationNavbarState();
}

class _AnimationNavbarState extends State<AnimationNavbar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animationTabBarIn;
  late Animation _animationTabBarOut;
  late Animation _animationCircle;
  late Animation _animationIconIn;
  late Animation _animationIconOut;

  int currentIndex = 0;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _animationTabBarIn = CurveTween(
      curve: const Interval(0.1, 0.6, curve: Curves.decelerate),
    ).animate(_controller);

    _animationTabBarOut = CurveTween(
      curve: const Interval(0.6, 1.0, curve: Curves.bounceOut),
    ).animate(_controller);

    _animationCircle = CurveTween(
      curve: const Interval(0.0, 0.5, curve: Curves.decelerate),
    ).animate(_controller);

    _animationIconIn = CurveTween(
      curve: const Interval(0.1, 0.6, curve: Curves.decelerate),
    ).animate(_controller);

    _animationIconOut = CurveTween(
      curve: const Interval(0.6, 1.0, curve: Curves.bounceOut),
    ).animate(_controller);

    // _controller.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     _controller.reverse();
    //   }
    // });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: const Center(child: Text("data")),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final currentWidth = width -
                (50 * _animationTabBarIn.value) +
                (50 * _animationTabBarOut.value);

            final double currentTranslate = -(50.0 * _animationIconIn.value) +
                (50.0 * _animationIconOut.value);

            return Center(
              child: Container(
                height: 70,
                width: currentWidth,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                  color: Colors.blue.shade200,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    if (currentIndex == index) {
                      return CustomPaint(
                        foregroundPainter: _CirclePaint(
                          progress: _animationCircle.value,
                        ),
                        child: Transform.translate(
                          offset: Offset(0.0, currentTranslate),
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            child: Icon(Icons.home, size: 30),
                          ),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = index;
                          });
                          _controller.forward(from: 0.0);
                        },
                        child: const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.home, size: 30),
                        ),
                      );
                    }
                  }),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CirclePaint extends CustomPainter {
  final double progress;
  _CirclePaint({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.height / 2, size.width / 2);
    final radius = 20.0 * progress;
    const strokeWidth = 10.0;
    final currentStrokeWidth = strokeWidth * progress;
    if (progress < 1.0) {
      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = currentStrokeWidth,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
