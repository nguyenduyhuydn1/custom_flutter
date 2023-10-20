import 'package:custom_flutter/feature/get_box_offset.dart';
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

    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: ValueListenableBuilder(
          valueListenable: offsets,
          builder: (context, value, child) {
            // print(value);
            return GestureDetector(
              onHorizontalDragUpdate: (details) {
                //middle
                // final calwidth = (size.width - 100) / 2;
                // if (details.primaryDelta! > 0) {
                //   if (offsets.value >= calwidth) return;
                // } else {
                //   if (offsets.value <= -calwidth) return;
                // }

                //block left
                final calwidth = (size.width - 100);
                if (details.primaryDelta! > 0) {
                  if (offsets.value >= calwidth) return;
                } else {
                  if (offsets.value <= 0) return;
                }

                //block right
                // final calwidth = (size.width - 100);
                // if (details.primaryDelta! < 0) {
                //   if (offsets.value <= -calwidth) return;
                // } else {
                //   if (offsets.value >= 0) return;
                // }

                offsets.value += details.primaryDelta!;
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(value, 0.0),
                      child: GetBoxOffset(
                        offset: (offset, box) {
                          // print(offset.dx);
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
