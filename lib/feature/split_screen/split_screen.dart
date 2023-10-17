import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplitScreen extends StatefulWidget {
  const SplitScreen({super.key});

  @override
  State<SplitScreen> createState() => _SplitScreenState();
}

class _SplitScreenState extends State<SplitScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double widthright = size.width * 0.2;
    double widthleft = size.width * 0.2;
    double heightright = size.height * 0.2;
    double heightleft = size.height * 0.2;

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => CardProvider(),
        child: Consumer<CardProvider>(
          builder: (context, value, child) {
            final positions = value.positions;
            final rotateMatrix = Matrix4.identity()
              ..translate(positions.dx, positions.dy);

            return Stack(
              children: [
                Positioned(
                  left: 40,
                  bottom: 0,
                  child: Container(
                    height: heightleft,
                    width: widthleft,
                    color: Colors.blue,
                  ),
                ),
                Positioned(
                  right: 40,
                  bottom: 0,
                  child: Container(
                    height: heightright,
                    width: widthright,
                    color: Colors.amber,
                  ),
                ),
                GestureDetector(
                  // onHorizontalDragStart: (details) {
                  //   print("Start");
                  // },
                  onHorizontalDragUpdate: (details) {
                    widthleft -= details.primaryDelta!;
                    widthright += details.primaryDelta!;

                    if (widthleft < 0) widthleft = 0;
                    if (widthright < 0) widthright = 0;

                    value.updatePosition(details);
                  },
                  // onHorizontalDragEnd: (details) {
                  //   print("end");
                  // },
                  onVerticalDragUpdate: (details) {
                    heightright -= details.primaryDelta!;
                    heightleft += details.primaryDelta!;

                    if (heightright < 0) heightright = 0;
                    if (heightleft < 0) heightleft = 0;

                    value.updatePosition(details);
                  },
                  child: Center(
                    child: Transform(
                      transform: rotateMatrix,
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CardProvider extends ChangeNotifier {
  Offset positions = Offset.zero;
  bool isDragging = false;
  Size screenSize = Size.zero;

  double angle = 0;

  void startPosition(DragStartDetails details) {
    isDragging = true;
    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    positions += details.delta;

    // final x = positions.dx;
    // angle = 45 * x / screenSize.width;

    notifyListeners();
  }

  // void setScreenSize(Size size) {
  //   screenSize = size;
  // }

  // void endPosition() {
  //   isDragging = false;

  //   final status = _getStatus();
  //   switch (status) {
  //     case CardStatus.like:
  //       like();
  //       break;
  //     case CardStatus.dislike:
  //       dislike();
  //       break;
  //     case CardStatus.superLike:
  //       superLike();
  //       break;
  //     default:
  //   }

  //   notifyListeners();
  // }

  // void like() {
  //   angle = 20;
  //   positions += Offset(2 * screenSize.width, 0);
  // }

  // void dislike() {
  //   angle = -20;
  //   positions -= Offset(2 * screenSize.width, 0);
  // }

  // void superLike() {
  //   angle = 0;
  //   positions -= Offset(0, screenSize.height);
  // }

  // CardStatus? _getStatus() {
  //   final x = positions.dx;
  //   final y = positions.dy;
  //   const delta = 100;

  //   final bool forceSuperLike = x.abs() < 20;

  //   if (x >= delta) {
  //     return CardStatus.like;
  //   } else if (x <= -delta) {
  //     return CardStatus.dislike;
  //   } else if (y <= -delta / 2 && forceSuperLike) {
  //     return CardStatus.superLike;
  //   } else {
  //     return CardStatus.superLike;
  //   }
  // }

  // void resetPositions() {
  //   isDragging = false;
  //   positions = Offset.zero;
  //   angle = 0;
  //   notifyListeners();
  // }
}
