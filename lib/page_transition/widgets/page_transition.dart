import 'package:flutter/material.dart';

class SlidePageTransition extends PageRouteBuilder {
  Widget secondpage;
  SlidePageTransition({required this.secondpage})
      : super(
          opaque: true,
          transitionDuration: const Duration(seconds: 3),
          reverseTransitionDuration: const Duration(microseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) => secondpage,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.easeInBack);
            return SlideTransition(
              position: Tween(
                      begin: // Offset(1, 0), //For Right to Left
                          //  Offset(-1, 0), //For Left to Right
                          // Offset(0, -1), //For Top to Bottom
                          const Offset(0, 1), //For Bottom to top
                      end: Offset.zero)
                  .animate(animation),
              child: child,
            );
          },
        );
}

class ScalePageTransition extends PageRouteBuilder {
  Widget secondpage;
  ScalePageTransition({required this.secondpage})
      : super(
          opaque: true,
          transitionDuration: const Duration(seconds: 3),
          reverseTransitionDuration: const Duration(seconds: 2),
          pageBuilder: (context, animation, secondaryAnimation) => secondpage,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.bounceIn);
            return ScaleTransition(
              scale: animation,
              alignment: Alignment.bottomCenter,
              child: child,
            );
          },
        );
}

class SizePageTransition extends PageRouteBuilder {
  Widget secondpage;
  SizePageTransition({required this.secondpage})
      : super(
          opaque: true,
          transitionDuration: const Duration(seconds: 3),
          reverseTransitionDuration: const Duration(seconds: 2),
          pageBuilder: (context, animation, secondaryAnimation) => secondpage,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.bounceIn);
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                axis: Axis.vertical,
                axisAlignment: -1,
                child: child,
              ),
            );
          },
        );
}

class FadePageTransition extends PageRouteBuilder {
  Widget secondpage;
  FadePageTransition({required this.secondpage})
      : super(
          opaque: true,
          transitionDuration: const Duration(seconds: 3),
          reverseTransitionDuration: const Duration(seconds: 2),
          pageBuilder: (context, animation, secondaryAnimation) => secondpage,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.linear);
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}

class RotatePageTransition extends PageRouteBuilder {
  Widget secondpage;
  RotatePageTransition({required this.secondpage})
      : super(
          opaque: true,
          transitionDuration: const Duration(seconds: 3),
          reverseTransitionDuration: const Duration(seconds: 2),
          pageBuilder: (context, animation, secondaryAnimation) => secondpage,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.bounceOut);
            return RotationTransition(
              turns: animation,
              alignment: Alignment.bottomCenter,
              child: child,
            );
          },
        );
}
