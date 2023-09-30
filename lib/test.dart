import 'dart:math';
import 'dart:ui';

import 'package:custom_flutter/testModel/models.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _toppingController;

  late AnimationController _addCartAnimation;
  late Animation _scalePizzaAnimation;
  late Animation _scaleBoxAnimation;
  late Animation _closeBoxAnimation;

  int _currentIndex = 0;

  int _currentSize = 0;
  final _size = ['S', 'M', "L"];

  List<Topping> selectedTopping = [];
  final ValueNotifier _notifierTopping = ValueNotifier(false);

  final List<Animation> _listAnimation = [];

  bool _expanded = false;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentIndex);

    _toppingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _addCartAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scalePizzaAnimation = Tween(begin: 1.0, end: 0.5).animate(CurvedAnimation(
      parent: _addCartAnimation,
      curve: const Interval(0.0, 0.2, curve: Curves.decelerate),
    ));

    _scaleBoxAnimation = CurvedAnimation(
      parent: _addCartAnimation,
      curve: const Interval(0.0, 0.4, curve: Curves.decelerate),
    );

    _closeBoxAnimation = CurvedAnimation(
      parent: _addCartAnimation,
      curve: const Interval(0.6, 1.0, curve: Curves.decelerate),
    );

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _toppingController.dispose();
    _addCartAnimation.dispose();

    super.dispose();
  }

  void _buildToppingAnimation() {
    _listAnimation.clear();
    for (var i = 0; i < 5; i++) {
      var begin = 0.0;
      var end = 0.0;
      begin = Random().nextDouble();
      end = Random().nextDouble();
      while (begin > end) {
        begin = Random().nextDouble();
        end = Random().nextDouble();
      }
      _listAnimation.add(CurvedAnimation(
        parent: _toppingController,
        curve: Interval(begin, end, curve: Curves.decelerate),
      ));
    }
  }

  late BoxConstraints boxConstraintsPizza;

  Widget _buildToppingWidget() {
    List<Widget> toppingWidget = [];
    if (selectedTopping.isNotEmpty) {
      final sizeWidth = _currentSize == 0
          ? 200
          : _currentSize == 1
              ? 150
              : 100;
      final widthConstraints = boxConstraintsPizza.maxWidth - sizeWidth;

      for (var i = 0; i < selectedTopping.length; i++) {
        Topping topping = selectedTopping[i];
        final image = Image.asset(topping.onPizza, width: 30, height: 30);

        for (var j = 0; j < topping.offset.length; j++) {
          final animation = _listAnimation[j];
          final position = topping.offset[j];
          final x = position.dx;
          final y = position.dy;
          if (i == selectedTopping.length - 1) {
            double fromX = 0.0, fromY = 0.0;
            if (j < 1) {
              fromX = -widthConstraints * (1 - animation.value);
            } else if (j < 2) {
              fromX = widthConstraints * (1 - animation.value);
            } else if (j < 4) {
              fromY = -widthConstraints * (1 - animation.value);
            } else {
              fromY = widthConstraints * (1 - animation.value);
            }
            if (animation.value > 0) {
              toppingWidget.add(Transform(
                transform: Matrix4.identity()
                  ..translate(
                    fromX + widthConstraints / 2 * x,
                    fromY + widthConstraints / 2 * y,
                  ),
                child: Container(color: Colors.red, child: image),
              ));
            }
          } else {
            toppingWidget.add(Transform(
              transform: Matrix4.identity()
                ..translate(
                  widthConstraints / 2 * x,
                  widthConstraints / 2 * y,
                ),
              child: Container(color: Colors.blue, child: image),
            ));
          }
        }
      }
      return Stack(children: toppingWidget);
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // appBar: const _Appbar(size: 100, title: "Pizza"),
      body: Column(children: [
        SizedBox(
          height: size.height * 0.5,
          width: size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _scaleBoxAnimation,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.topCenter,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.003)
                      ..rotateX((-45.0 * pi) / 180.0)
                      ..scale(_scaleBoxAnimation.value),
                    child: Image.asset(
                      boxPizzas[2].image,
                      width: 200,
                      height: 200,
                    ),
                  );
                },
              ),
              AnimatedBuilder(
                animation: _scalePizzaAnimation,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..scale(_scalePizzaAnimation.value)
                      ..rotateZ(pi * _scalePizzaAnimation.value),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(dish, width: 350),
                        PageView.builder(
                          controller: _pageController,
                          itemCount: dataPizza.length,
                          onPageChanged: (value) {
                            setState(() {
                              _currentIndex = value;
                              selectedTopping = [];
                            });
                          },
                          itemBuilder: (context, index) {
                            final item = dataPizza[index];
                            final double check = _currentSize == 0
                                ? 0.8
                                : _currentSize == 1
                                    ? 0.9
                                    : 1;

                            return Center(
                              child: Transform.scale(
                                scale: check,
                                child: DragTarget<Topping>(
                                  onAccept: (data) {
                                    _notifierTopping.value = false;
                                    setState(() {
                                      selectedTopping.add(data);
                                    });
                                    _buildToppingAnimation();
                                    _toppingController.forward(from: 0.0);
                                  },
                                  onWillAccept: (data) {
                                    _notifierTopping.value = false;
                                    for (Topping topping in selectedTopping) {
                                      if (topping.onList == data!.onList) {
                                        return false;
                                      }
                                    }

                                    return true;
                                  },
                                  onLeave: (data) {
                                    _notifierTopping.value = false;
                                  },
                                  builder:
                                      (context, candidateData, rejectedData) {
                                    return SizedBox(
                                      width: 350,
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          boxConstraintsPizza = constraints;

                                          return Image.asset(item.image,
                                              fit: BoxFit.cover);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        AnimatedBuilder(
                          animation: _toppingController,
                          builder: (context, child) {
                            return _buildToppingWidget();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              AnimatedBuilder(
                animation: Listenable.merge([
                  _scaleBoxAnimation,
                  _closeBoxAnimation,
                ]),
                builder: (context, child) {
                  final aa =
                      (lerpDouble(-145, -45, _closeBoxAnimation.value)! * pi) /
                          180.0;

                  return Transform(
                    alignment: Alignment.topCenter,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.003)
                      // ..rotateX((-130.0 * pi) / 180.0),
                      ..rotateX(aa)
                      ..scale(_scaleBoxAnimation.value),
                    child: Image.asset(
                      boxPizzas[1].image,
                      width: 200,
                      height: 200,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const _Price(),
        const SizedBox(height: 20),
        _Size(
            size: _size,
            currentSize: _currentSize,
            onPressed: (v) {
              setState(() {
                _currentSize = v;
              });
            }),
        const SizedBox(height: 20),
        const _Topping(),
        const SizedBox(height: 20),
        _Submit(onPressed: () {
          setState(() {
            _expanded = !_expanded;
          });
          if (_expanded) {
            _addCartAnimation.forward();
          } else {
            _addCartAnimation.reverse();
          }

          // _boxController.forward(from: 0.0);
        }),
        const SizedBox(height: 50),
      ]),
    );
  }
}

class _Size extends StatelessWidget {
  const _Size({
    required this.currentSize,
    required this.size,
    required this.onPressed,
  });

  final Function(int) onPressed;
  final int currentSize;
  final List<String> size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(size.length, (index) {
            final item = size[index];
            return GestureDetector(
              onTap: () => onPressed(index),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 20,
                      color: index == currentSize ? Colors.red : Colors.white,
                    ),
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}

class _Submit extends StatelessWidget {
  final VoidCallback onPressed;
  const _Submit({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: onPressed, child: const Text("Add Cart"));
  }
}

class _Price extends StatelessWidget {
  const _Price();

  @override
  Widget build(BuildContext context) {
    return const Text(
      "\$1",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////// _Topping
class _Topping extends StatefulWidget {
  const _Topping();

  @override
  State<_Topping> createState() => _ToppingState();
}

class _ToppingState extends State<_Topping> {
  late PageController _toppingController;
  final int _currentIndex = 2;
  final double _viewportFraction = 0.25;
  double _percent = 0.0;

  @override
  void initState() {
    _toppingController = PageController(
      initialPage: _currentIndex,
      viewportFraction: _viewportFraction,
    )..addListener(() {
        _percent = _toppingController.page!;
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    _toppingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: _toppingController,
        itemCount: toppings.length,
        itemBuilder: (context, index) {
          final item = toppings[index];

          double paddingBottom = 0;
          if (_toppingController.position.haveDimensions) {
            paddingBottom = (index - _percent).abs() * 40;
          } else {
            if (index == 0 || index == 1 || index == 3 || index == 4) {
              paddingBottom = (index - 2).abs() * 40;
            }
            if (index == 2) {
              paddingBottom = (index - 2).abs() * 40;
            }
          }

          return Padding(
            padding: EdgeInsets.only(bottom: paddingBottom),
            child: Center(
              child: Draggable(
                feedback: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black38, width: 5),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    item.onPizza,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                onDragUpdate: (details) {},
                onDragStarted: () {},
                onDragEnd: (details) {},
                data: item,
                child: Image.asset(
                  item.onPizza,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Appbar extends StatelessWidget implements PreferredSizeWidget {
  final double size;
  final String title;
  const _Appbar({required this.size, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
