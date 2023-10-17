import 'package:flutter/material.dart';

class LimitDrag extends StatefulWidget {
  const LimitDrag({super.key});

  @override
  State<LimitDrag> createState() => _LimitDragState();
}

class _LimitDragState extends State<LimitDrag> {
  ValueNotifier<double> offsets = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(size.width);

    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: offsets,
        builder: (context, value, child) {
          print(value);
          return GestureDetector(
            onHorizontalDragUpdate: (details) {
              final calwidth = (size.width - 100) / 2;

              if (details.primaryDelta! > 0) {
                if (offsets.value >= calwidth) return;
              } else {
                if (offsets.value <= -calwidth) return;
              }
              offsets.value += details.primaryDelta!;
            },
            child: Transform.translate(
              offset: Offset(value, 0.0),
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
