import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class DelayUntilComplete extends StatefulWidget {
  const DelayUntilComplete({super.key});

  @override
  State<DelayUntilComplete> createState() => _DelayUntilCompleteState();
}

class _DelayUntilCompleteState extends State<DelayUntilComplete>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(const Duration(seconds: 1));
      }
    });
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Timeline.tileBuilder(
        builder: TimelineTileBuilder.fromStyle(
          itemCount: 15,
          contentsAlign: ContentsAlign.alternating,
          contentsBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(24.0),
            child: SlideInUp(
              from: 100 * -1,
              duration: Duration(seconds: index * 1),
              delay: Duration(seconds: index * 1),
              child: FadeIn(
                duration: Duration(seconds: index * 1),
                delay: Duration(seconds: index * 1),
                child: Text('My Event $index'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SlideInUp extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  SlideInUp(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 600),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  SlideInUpState createState() => SlideInUpState();
}

/// State class, where the magic happens
class SlideInUpState extends State<SlideInUp>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool disposed = false;
  late Animation<double> animation;

  @override
  void dispose() {
    disposed = true;
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation = Tween<double>(begin: widget.from, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate &&
        widget.delay.inMilliseconds == 0 &&
        widget.manualTrigger == false) {
      controller.forward();
    }

    /// If FALSE, animate everything back to the original state
    if (!widget.animate) {
      controller.animateBack(0);
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
              offset: Offset(0, animation.value), child: widget.child);
        });
  }
}

class FadeIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;

  FadeIn(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 500),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  FadeInState createState() => FadeInState();
}

/// FadeState class
/// The animation magic happens here
class FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  /// Animation controller that controls this animation
  late AnimationController controller;

  /// is the widget disposed?
  bool disposed = false;

  /// Animation movement value
  late Animation<double> animation;

  @override
  void dispose() {
    disposed = true;
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);
    animation = CurvedAnimation(curve: Curves.easeOut, parent: controller);

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Launch the animation ASAP or wait if is needed
    if (widget.animate &&
        widget.delay.inMilliseconds == 0 &&
        widget.manualTrigger == false) {
      controller.forward();
    }

    /// If the animation already happen, we can animate it back
    if (!widget.animate) {
      controller.animateBack(0);
    }

    /// Builds the animation with the corresponding
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return Opacity(
            opacity: animation.value,
            child: widget.child,
          );
        });
  }
}
