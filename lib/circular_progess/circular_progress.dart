import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomCircularProgress extends StatefulWidget {
  const CustomCircularProgress({super.key});

  @override
  State<CustomCircularProgress> createState() => _CustomCircularProgressState();
}

class _CustomCircularProgressState extends State<CustomCircularProgress>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> move = ValueNotifier(true);

  late AnimationController _controller;
  late Animation<Color> a;

  bool check = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    a = Tween(begin: Colors.red, end: Colors.blue).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: ListView(children: <Widget>[
              CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 10.0,
                percent: 0.8,
                header: const Text("Icon header"),
                center: const Icon(
                  Icons.person_pin,
                  size: 50.0,
                  color: Colors.blue,
                ),
                backgroundColor: Colors.grey,
                progressColor: Colors.blue,
              ),
              CircularPercentIndicator(
                radius: 130.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: 0.4,
                center: const Text(
                  "40 hours",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Colors.yellow,
                progressColor: Colors.red,
              ),
              CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 13.0,
                animation: true,
                percent: 0.7,
                center: const Text(
                  "70.0%",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: const Text(
                  "Sales this week",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.purple,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  percent: 1.0,
                  center: const Text("100%"),
                  progressColor: Colors.green,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularPercentIndicator(
                      radius: 45.0,
                      lineWidth: 4.0,
                      percent: 0.10,
                      center: const Text("10%"),
                      progressColor: Colors.red,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    CircularPercentIndicator(
                      radius: 45.0,
                      lineWidth: 4.0,
                      percent: 0.30,
                      center: const Text("30%"),
                      progressColor: Colors.orange,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    CircularPercentIndicator(
                      radius: 45.0,
                      lineWidth: 4.0,
                      percent: 0.60,
                      center: const Text("60%"),
                      progressColor: Colors.yellow,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    CircularPercentIndicator(
                      radius: 45.0,
                      lineWidth: 4.0,
                      percent: 0.90,
                      center: const Text("90%"),
                      progressColor: Colors.green,
                    )
                  ],
                ),
              ),
              check ? const _CountDown() : const SizedBox.shrink(),
              SizedBox(
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      check = !check;
                    });
                  },
                  child: const Text("Button"),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _CountDown extends StatefulWidget {
  const _CountDown();

  @override
  State<_CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<_CountDown>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _controller.reverse(from: 1);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final seconds = _controller.duration! * _controller.value;
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                value: _controller.value,
              ),
            ),
            Text(seconds.inSeconds.toString()),
          ],
        );
      },
    );
  }
}

enum ArcType { HALF, FULL, FULL_REVERSED }

enum CircularStrokeCap { butt, round, square }

extension CircularStrokeCapExtension on CircularStrokeCap {
  StrokeCap get strokeCap {
    switch (this) {
      case CircularStrokeCap.butt:
        return StrokeCap.butt;
      case CircularStrokeCap.round:
        return StrokeCap.round;
      case CircularStrokeCap.square:
        return StrokeCap.square;
    }
  }
}

num radians(num deg) => deg * (math.pi / 180.0);

// ignore: must_be_immutable
class CircularPercentIndicator extends StatefulWidget {
  ///Percent value between 0.0 and 1.0
  final double percent;
  final double radius;

  ///Width of the progress bar of the circle
  final double lineWidth;

  ///Width of the unfilled background of the progress bar
  final double backgroundWidth;

  ///First color applied to the complete circle
  final Color fillColor;

  ///Color of the border of the progress bar , default = null
  final Color? progressBorderColor;

  ///Color of the background of the circle , default = transparent
  final Color backgroundColor;

  Color get progressColor => _progressColor;

  late Color _progressColor;

  ///true if you want the circle to have animation
  final bool animation;

  ///duration of the animation in milliseconds, It only applies if animation attribute is true
  final int animationDuration;

  ///widget at the top of the circle
  final Widget? header;

  ///widget at the bottom of the circle
  final Widget? footer;

  ///widget inside the circle
  final Widget? center;

  final LinearGradient? linearGradient;

  ///The kind of finish to place on the end of lines drawn, values supported: butt, round, square
  final CircularStrokeCap circularStrokeCap;

  ///the angle which the circle will start the progress (in degrees, eg: 0.0, 45.0, 90.0)
  final double startAngle;

  /// set true if you want to animate the linear from the last percent value you set
  final bool animateFromLastPercent;

  /// set false if you don't want to preserve the state of the widget
  final bool addAutomaticKeepAlive;

  /// set the arc type
  final ArcType? arcType;

  /// set a circular background color when use the arcType property
  final Color? arcBackgroundColor;

  /// set true when you want to display the progress in reverse mode
  final bool reverse;

  /// Creates a mask filter that takes the progress shape being drawn and blurs it.
  final MaskFilter? maskFilter;

  /// set a circular curve animation type
  final Curve curve;

  /// set true when you want to restart the animation, it restarts only when reaches 1.0 as a value
  /// defaults to false
  final bool restartAnimation;

  /// Callback called when the animation ends (only if `animation` is true)
  final VoidCallback? onAnimationEnd;

  /// Display a widget indicator at the end of the progress. It only works when `animation` is true
  final Widget? widgetIndicator;

  /// Set to true if you want to rotate linear gradient in accordance to the [startAngle].
  final bool rotateLinearGradient;

  CircularPercentIndicator({
    Key? key,
    this.percent = 0.0,
    this.lineWidth = 5.0,
    this.startAngle = 0.0,
    required this.radius,
    this.fillColor = Colors.transparent,
    this.backgroundColor = const Color(0xFFB8C7CB),
    Color? progressColor,
    //negative values ignored, replaced with lineWidth
    this.backgroundWidth = -1,
    this.linearGradient,
    this.animation = false,
    this.animationDuration = 500,
    this.header,
    this.footer,
    this.center,
    this.addAutomaticKeepAlive = true,
    this.circularStrokeCap = CircularStrokeCap.butt,
    this.arcBackgroundColor,
    this.arcType,
    this.animateFromLastPercent = false,
    this.reverse = false,
    this.curve = Curves.linear,
    this.maskFilter,
    this.restartAnimation = false,
    this.onAnimationEnd,
    this.widgetIndicator,
    this.rotateLinearGradient = false,
    this.progressBorderColor,
  }) : super(key: key) {
    if (linearGradient != null && progressColor != null) {
      throw ArgumentError(
          'Cannot provide both linearGradient and progressColor');
    }
    _progressColor = progressColor ?? Colors.red;

    assert(startAngle >= 0.0);
    if (percent < 0.0 || percent > 1.0) {
      throw Exception(
          "Percent value must be a double between 0.0 and 1.0, but it's $percent");
    }

    if (arcType == null && arcBackgroundColor != null) {
      throw ArgumentError('arcType is required when you arcBackgroundColor');
    }
  }

  @override
  _CircularPercentIndicatorState createState() =>
      _CircularPercentIndicatorState();
}

class _CircularPercentIndicatorState extends State<CircularPercentIndicator>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController? _animationController;
  Animation? _animation;
  double _percent = 0.0;
  double _diameter = 0.0;

  @override
  void dispose() {
    if (_animationController != null) {
      _animationController!.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    if (widget.animation) {
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.animationDuration),
      );
      _animation = Tween(begin: 0.0, end: widget.percent).animate(
        CurvedAnimation(parent: _animationController!, curve: widget.curve),
      )..addListener(() {
          setState(() {
            _percent = _animation!.value;
          });
          if (widget.restartAnimation && _percent == 1.0) {
            _animationController!.repeat(min: 0, max: 1.0);
          }
        });
      _animationController!.addStatusListener((status) {
        if (widget.onAnimationEnd != null &&
            status == AnimationStatus.completed) {
          widget.onAnimationEnd!();
        }
      });
      _animationController!.forward();
    } else {
      _updateProgress();
    }
    _diameter = widget.radius * 2;
    super.initState();
  }

  void _checkIfNeedCancelAnimation(CircularPercentIndicator oldWidget) {
    if (oldWidget.animation &&
        !widget.animation &&
        _animationController != null) {
      _animationController!.stop();
    }
  }

  @override
  void didUpdateWidget(CircularPercentIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.percent != widget.percent ||
        oldWidget.startAngle != widget.startAngle) {
      if (_animationController != null) {
        _animationController!.duration =
            Duration(milliseconds: widget.animationDuration);
        _animation = Tween(
          begin: widget.animateFromLastPercent ? oldWidget.percent : 0.0,
          end: widget.percent,
        ).animate(
          CurvedAnimation(parent: _animationController!, curve: widget.curve),
        );
        _animationController!.forward(from: 0.0);
      } else {
        _updateProgress();
      }
    }
    _checkIfNeedCancelAnimation(oldWidget);
  }

  _updateProgress() {
    setState(() => _percent = widget.percent);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var items = List<Widget>.empty(growable: true);
    if (widget.header != null) {
      items.add(widget.header!);
    }
    items.add(
      SizedBox(
        height: _diameter,
        width: _diameter,
        child: Stack(
          children: [
            CustomPaint(
              painter: _CirclePainter(
                progress: _percent * 360,
                progressColor: widget.progressColor,
                progressBorderColor: widget.progressBorderColor,
                backgroundColor: widget.backgroundColor,
                startAngle: widget.startAngle,
                circularStrokeCap: widget.circularStrokeCap,
                radius: widget.radius - widget.lineWidth / 2,
                lineWidth: widget.lineWidth,
                //negative values ignored, replaced with lineWidth
                backgroundWidth: widget.backgroundWidth >= 0.0
                    ? (widget.backgroundWidth)
                    : widget.lineWidth,
                arcBackgroundColor: widget.arcBackgroundColor,
                arcType: widget.arcType,
                reverse: widget.reverse,
                linearGradient: widget.linearGradient,
                maskFilter: widget.maskFilter,
                rotateLinearGradient: widget.rotateLinearGradient,
              ),
              child: (widget.center != null)
                  ? Center(child: widget.center)
                  : const SizedBox.expand(),
            ),
            if (widget.widgetIndicator != null && widget.animation)
              Positioned.fill(
                child: Transform.rotate(
                  angle: radians(
                          (widget.circularStrokeCap != CircularStrokeCap.butt &&
                                  widget.reverse)
                              ? -15
                              : 0)
                      .toDouble(),
                  child: Transform.rotate(
                    angle: getCurrentPercent(_percent),
                    child: Transform.translate(
                      offset: Offset(
                        (widget.circularStrokeCap != CircularStrokeCap.butt)
                            ? widget.lineWidth / 2
                            : 0,
                        (-widget.radius + widget.lineWidth / 2),
                      ),
                      child: widget.widgetIndicator,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    if (widget.footer != null) {
      items.add(widget.footer!);
    }

    return Material(
      color: widget.fillColor,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: items,
        ),
      ),
    );
  }

  double getCurrentPercent(double percent) {
    if (widget.arcType != null) {
      final angle = _getStartAngleFixedMargin(widget.arcType!).fixedStartAngle;
      final fixedPercent =
          widget.percent > 0 ? 1.0 / widget.percent * _percent : 0;
      late double margin;
      if (widget.arcType == ArcType.HALF) {
        margin = 180 * widget.percent;
      } else {
        margin = 280 * widget.percent;
      }
      return radians(angle + margin * fixedPercent).toDouble();
    } else {
      const angle = 360;
      return radians((widget.reverse ? -angle : angle) * _percent).toDouble();
    }
  }

  @override
  bool get wantKeepAlive => widget.addAutomaticKeepAlive;
}

_ArcAngles _getStartAngleFixedMargin(ArcType arcType) {
  double fixedStartAngle, startAngleFixedMargin;
  if (arcType == ArcType.FULL_REVERSED) {
    fixedStartAngle = 399;
    startAngleFixedMargin = 312 / fixedStartAngle;
  } else if (arcType == ArcType.FULL) {
    fixedStartAngle = 220;
    startAngleFixedMargin = 172 / fixedStartAngle;
  } else {
    fixedStartAngle = 270;
    startAngleFixedMargin = 135 / fixedStartAngle;
  }
  return _ArcAngles(
    fixedStartAngle: fixedStartAngle,
    startAngleFixedMargin: startAngleFixedMargin,
  );
}

class _ArcAngles {
  const _ArcAngles(
      {required this.fixedStartAngle, required this.startAngleFixedMargin});
  final double fixedStartAngle;
  final double startAngleFixedMargin;
}

class _CirclePainter extends CustomPainter {
  final Paint _paintBackground = Paint();
  final Paint _paintLine = Paint();
  final Paint _paintLineBorder = Paint();
  final Paint _paintBackgroundStartAngle = Paint();
  final double lineWidth;
  final double backgroundWidth;
  final double progress;
  final double radius;
  final Color progressColor;
  final Color? progressBorderColor;
  final Color backgroundColor;
  final CircularStrokeCap circularStrokeCap;
  final double startAngle;
  final LinearGradient? linearGradient;
  final Color? arcBackgroundColor;
  final ArcType? arcType;
  final bool reverse;
  final MaskFilter? maskFilter;
  final bool rotateLinearGradient;

  _CirclePainter({
    required this.lineWidth,
    required this.backgroundWidth,
    required this.progress,
    required this.radius,
    required this.progressColor,
    required this.backgroundColor,
    this.progressBorderColor,
    this.startAngle = 0.0,
    this.circularStrokeCap = CircularStrokeCap.butt,
    this.linearGradient,
    required this.reverse,
    this.arcBackgroundColor,
    this.arcType,
    this.maskFilter,
    required this.rotateLinearGradient,
  }) {
    _paintBackground.color = backgroundColor;
    _paintBackground.style = PaintingStyle.stroke;
    _paintBackground.strokeWidth = backgroundWidth;
    _paintBackground.strokeCap = circularStrokeCap.strokeCap;

    if (arcBackgroundColor != null) {
      _paintBackgroundStartAngle.color = arcBackgroundColor!;
      _paintBackgroundStartAngle.style = PaintingStyle.stroke;
      _paintBackgroundStartAngle.strokeWidth = lineWidth;
      _paintBackgroundStartAngle.strokeCap = circularStrokeCap.strokeCap;
    }

    _paintLine.color = progressColor;
    _paintLine.style = PaintingStyle.stroke;
    _paintLine.strokeWidth =
        progressBorderColor != null ? lineWidth - 2 : lineWidth;
    _paintLine.strokeCap = circularStrokeCap.strokeCap;

    if (progressBorderColor != null) {
      _paintLineBorder.color = progressBorderColor!;
      _paintLineBorder.style = PaintingStyle.stroke;
      _paintLineBorder.strokeWidth = lineWidth;
      _paintLineBorder.strokeCap = circularStrokeCap.strokeCap;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    double fixedStartAngle = startAngle;
    double startAngleFixedMargin = 1.0;
    if (arcType != null) {
      final arcAngles = _getStartAngleFixedMargin(arcType!);
      fixedStartAngle = arcAngles.fixedStartAngle;
      startAngleFixedMargin = arcAngles.startAngleFixedMargin;
    }
    if (arcType == null) {
      canvas.drawCircle(center, radius, _paintBackground);
    }

    if (maskFilter != null) {
      _paintLineBorder.maskFilter = _paintLine.maskFilter = maskFilter;
    }
    if (linearGradient != null) {
      if (rotateLinearGradient && progress > 0) {
        double correction = 0;
        if (_paintLine.strokeCap != StrokeCap.butt) {
          correction = math.atan(_paintLine.strokeWidth / 2 / radius);
        }
        _paintLineBorder.shader = _paintLine.shader = SweepGradient(
          transform: reverse
              ? GradientRotation(
                  radians(-90 - progress + startAngle) - correction)
              : GradientRotation(radians(-90.0 + startAngle) - correction),
          startAngle: radians(0).toDouble(),
          endAngle: radians(progress).toDouble(),
          tileMode: TileMode.clamp,
          colors: reverse
              ? linearGradient!.colors.reversed.toList()
              : linearGradient!.colors,
        ).createShader(
          Rect.fromCircle(center: center, radius: radius),
        );
      } else if (!rotateLinearGradient) {
        _paintLineBorder.shader =
            _paintLine.shader = linearGradient!.createShader(
          Rect.fromCircle(center: center, radius: radius),
        );
      }
    }

    if (arcBackgroundColor != null) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        radians(-90.0 + fixedStartAngle).toDouble(),
        radians(360 * startAngleFixedMargin).toDouble(),
        false,
        _paintBackgroundStartAngle,
      );
    }

    if (reverse) {
      final start =
          radians(360 * startAngleFixedMargin - 90.0 + fixedStartAngle)
              .toDouble();
      final end = radians(-progress * startAngleFixedMargin).toDouble();
      if (progressBorderColor != null) {
        canvas.drawArc(
          Rect.fromCircle(
            center: center,
            radius: radius,
          ),
          start,
          end,
          false,
          _paintLineBorder,
        );
      }
      canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
        start,
        end,
        false,
        _paintLine,
      );
    } else {
      final start = radians(-90.0 + fixedStartAngle).toDouble();
      final end = radians(progress * startAngleFixedMargin).toDouble();
      if (progressBorderColor != null) {
        canvas.drawArc(
          Rect.fromCircle(
            center: center,
            radius: radius,
          ),
          start,
          end,
          false,
          _paintLineBorder,
        );
      }
      canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
        start,
        end,
        false,
        _paintLine,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
