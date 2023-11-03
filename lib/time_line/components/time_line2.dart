import 'package:flutter/material.dart';

import 'enums/enums.dart';

class TimeLine2 extends StatelessWidget {
  const TimeLine2({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: size.height, child: const Enums()),
        ],
      ),
    );
  }
}
