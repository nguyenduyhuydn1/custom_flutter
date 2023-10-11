import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class M5 {
  final bool isSelected;
  final Color color;
  final int index;

  M5({
    required this.isSelected,
    required this.color,
    required this.index,
  });
}

class Tinder extends StatefulWidget {
  const Tinder({super.key});

  @override
  State<Tinder> createState() => _TinderState();
}

class _TinderState extends State<Tinder> {
  List<M5> dataM4 = [
    M5(isSelected: false, color: Colors.red, index: 0),
    M5(isSelected: false, color: Colors.blue, index: 1),
    M5(isSelected: false, color: Colors.green, index: 2),
    M5(isSelected: false, color: Colors.amber, index: 3),
  ];

  int currentIndex = 3;

  void setCurrentIndex() {
    currentIndex = currentIndex - 1;
    dataM4.removeLast();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              ...List.generate(dataM4.length, (index) {
                final item = dataM4[index];
                final checkIsFront = currentIndex == index;
                return Block(
                  size: size,
                  item: item,
                  checkIsFront: checkIsFront,
                  onPressed: setCurrentIndex,
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class Block extends StatefulWidget {
  const Block({
    super.key,
    required this.size,
    required this.item,
    required this.checkIsFront,
    required this.onPressed,
  });
  final VoidCallback onPressed;

  final Size size;
  final M5 item;
  final bool checkIsFront;

  @override
  State<Block> createState() => _BlockState();
}

class _BlockState extends State<Block> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<CardProvider>(context, listen: false);

      final size = MediaQuery.of(context).size;
      provider.setScreenSize(size);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.checkIsFront) {
      return LayoutBuilder(builder: (context, constraints) {
        return Consumer<CardProvider>(
          builder: (context, model, child) {
            final positions = model.positions;
            var duration = model.isDragging ? 0 : 400;

            final center = constraints.smallest.center(Offset.zero);

            final angle = model.angle * pi / 180;
            final rotateMatrix = Matrix4.identity()
              ..translate(center.dx, center.dy)
              ..rotateZ(angle)
              ..translate(-center.dx, -center.dy)
              ..translate(positions.dx, positions.dy);

            return GestureDetector(
              onPanStart: (details) {
                model.startPosition(details);
              },
              onPanUpdate: (details) {
                model.updatePosition(details);
              },
              onPanEnd: (details) async {
                model.endPosition();
                await Future.delayed(const Duration(milliseconds: 300), () {
                  widget.onPressed();

                  model.resetPositions();
                });
              },
              child: Center(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: duration),
                  curve: Curves.easeInOut,
                  transform: rotateMatrix,
                  width: widget.size.width * 0.5,
                  height: widget.size.height * 0.5,
                  color: widget.item.color,
                  child: Center(
                    child: Text(widget.item.index.toString()),
                  ),
                ),
              ),
            );
          },
        );
      });
    }
    return Container(
      width: widget.size.width * 0.5,
      height: widget.size.height * 0.5,
      color: widget.item.color,
      child: Center(
        child: Text(widget.item.index.toString()),
      ),
    );
  }
}

enum CardStatus { like, dislike, superLike }

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

    final x = positions.dx;
    angle = 45 * x / screenSize.width;

    notifyListeners();
  }

  void setScreenSize(Size size) {
    screenSize = size;
  }

  void endPosition() {
    isDragging = false;

    final status = _getStatus();
    switch (status) {
      case CardStatus.like:
        like();
        break;
      case CardStatus.dislike:
        dislike();
        break;
      case CardStatus.superLike:
        superLike();
        break;
      default:
    }

    notifyListeners();
  }

  void like() {
    angle = 20;
    positions += Offset(2 * screenSize.width, 0);
  }

  void dislike() {
    angle = -20;
    positions -= Offset(2 * screenSize.width, 0);
  }

  void superLike() {
    angle = 0;
    positions -= Offset(0, screenSize.height);
  }

  CardStatus? _getStatus() {
    final x = positions.dx;
    final y = positions.dy;
    const delta = 100;

    final bool forceSuperLike = x.abs() < 20;

    if (x >= delta) {
      return CardStatus.like;
    } else if (x <= -delta) {
      return CardStatus.dislike;
    } else if (y <= -delta / 2 && forceSuperLike) {
      return CardStatus.superLike;
    } else {
      return CardStatus.superLike;
    }
  }

  void resetPositions() {
    isDragging = false;
    positions = Offset.zero;
    angle = 0;
    notifyListeners();
  }
}
