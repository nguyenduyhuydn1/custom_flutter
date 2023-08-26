import 'package:flutter/material.dart';

class Card1 extends StatelessWidget {
  const Card1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            alignment: Alignment.topCenter,
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(60),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              gradient: LinearGradient(
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  colors: [Colors.red, Colors.blue]),
            ),
            child: FractionalTranslation(
              translation: const Offset(-0.25, -0.5),
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white38,
                  shape: BoxShape.circle,
                ),
              ),
            ),

//clip.none giup khong bi cat khi ra ngoai
            //     Stack(
            //   alignment: Alignment.topCenter,
            //   clipBehavior: Clip.none,
            //   children: [
            //     Positioned(
            //       right: 10,
            //       top: -50,
            //       child: Container(
            //         width: 100,
            //         height: 100,
            //         decoration: const BoxDecoration(
            //           color: Colors.white38,
            //           shape: BoxShape.circle,
            //         ),
            //       ),
            //     )
            //   ],
            // ),
          ),
        ]),
      ],
    );
  }
}
