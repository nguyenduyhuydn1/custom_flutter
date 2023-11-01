import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class TimeLineHorizontal extends StatefulWidget {
  const TimeLineHorizontal({super.key});

  @override
  State<TimeLineHorizontal> createState() => _TimeLineHorizontalState();
}

class _TimeLineHorizontalState extends State<TimeLineHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Timeline.tileBuilder(
        builder: TimelineTileBuilder.fromStyle(
          itemCount: 15,
          contentsAlign: ContentsAlign.alternating,
          contentsBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(24.0),
            child: TweenAnimationBuilder(
              duration: Duration(milliseconds: index * 300),
              tween: Tween<double>(begin: 1, end: 0),
              curve: Curves.linear,
              builder: (context, double value, child) {
                return Opacity(
                  opacity: lerpDouble(1.0, 0.0, value)!,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..translate(
                        lerpDouble(0.0, -200.0, value)!,
                        0.0,
                      ),
                    child: Text('My Event $index'),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
