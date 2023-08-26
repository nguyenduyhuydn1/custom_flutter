import 'package:flutter/material.dart';

class SpaceSliverToBox extends StatelessWidget {
  const SpaceSliverToBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            color: Colors.orange,
            height: 200,
          ),
          Container(
            color: Colors.red,
            height: 200,
          ),
          Container(
            color: Colors.yellow,
            height: 200,
          ),
          Container(
            color: Colors.amber,
            height: 200,
          ),
          Container(
            color: Colors.blueGrey,
            height: 200,
          ),
        ],
      ),
    );
  }
}
