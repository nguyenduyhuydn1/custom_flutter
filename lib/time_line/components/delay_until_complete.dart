import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class DelayUntilComplete extends StatefulWidget {
  const DelayUntilComplete({super.key});

  @override
  State<DelayUntilComplete> createState() => _DelayUntilCompleteState();
}

class _DelayUntilCompleteState extends State<DelayUntilComplete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Timeline.tileBuilder(
        builder: TimelineTileBuilder.fromStyle(
          itemCount: 15,
          contentsAlign: ContentsAlign.alternating,
          contentsBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text('My Event $index'),
          ),
        ),
      ),
    );
  }
}
