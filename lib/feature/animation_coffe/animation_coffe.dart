import 'dart:ui';

import 'package:custom_flutter/feature/animation_coffe/models/coffee.dart';
import 'package:flutter/material.dart';

class AnimationCoffe extends StatefulWidget {
  const AnimationCoffe({super.key});

  @override
  State<AnimationCoffe> createState() => _AnimationCoffeState();
}

class _AnimationCoffeState extends State<AnimationCoffe> {
  late PageController _slidePageController;
  late PageController _titlePageController;
  double _percent = 0.0;
  int _currentIndex = 2;
  int _numberPage = 0;

  void controllerListener() {
    //huong don, animation 1 huong
    // print(_slidePageController.position.userScrollDirection);

    _numberPage = _slidePageController.page!.floor();
    _currentIndex = _slidePageController.page!.floor() % coffes.length;
    _percent =
        (_slidePageController.page! % coffes.length - _currentIndex).abs();

    _titlePageController.jumpTo(_slidePageController.page! %
        coffes.length *
        MediaQuery.of(context).size.width);

    // _currentIndex = _slidePageController.page!.floor();
    // _percent = (_slidePageController.page! - _currentIndex).abs();

    // _titlePageController.jumpTo(
    //     _slidePageController.page! * MediaQuery.of(context).size.width);
    setState(() {});
  }

  @override
  void initState() {
    // auto scroll
    // _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
    //   if (_currentPage < intros.length - 1) {
    //     _currentPage++;
    //   } else {
    //     _currentPage = 0;
    //   }
    //   _pageController.animateToPage(
    //     _currentPage,
    //     duration: const Duration(milliseconds: 350),
    //     curve: Curves.easeIn,
    //   );

    _slidePageController = PageController(initialPage: _currentIndex);
    _titlePageController = PageController(initialPage: _currentIndex);

    _slidePageController.addListener(controllerListener);
    super.initState();
  }

  @override
  void dispose() {
    _slidePageController.removeListener(controllerListener);
    _slidePageController.dispose();
    _titlePageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * .15,
            child: PageView.builder(
              controller: _titlePageController,
              physics: const NeverScrollableScrollPhysics(),
              // physics: const BouncingScrollPhysics(),
              // itemCount: coffes.length,
              itemBuilder: (context, index) {
                final item = coffes[index % coffes.length];
                return _Title(item: item);
              },
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                const Positioned.fill(child: _Background()),
                //carousel
                _Carousel(
                  currentIndex: _currentIndex,
                  percent: _percent,
                  coffes: coffes,
                  numberPage: _numberPage,
                ),
                //details page
                PageView.builder(
                  controller: _slidePageController,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  // itemCount: coffes.length,
                  itemBuilder: (context, index) {
                    return Container(color: Colors.transparent);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Carousel extends StatelessWidget {
  const _Carousel({
    required this.currentIndex,
    required this.percent,
    required this.coffes,
    required this.numberPage,
  });
  final int currentIndex;
  final double percent;
  final List<CoffeeModel> coffes;
  final int numberPage;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final height = constraints.maxHeight;
      if (numberPage >= coffes.length - 1) {
        return Stack(
          alignment: Alignment.center,
          children: [
            //three
            Transform.scale(
              scale: lerpDouble(0.3, 0, percent),
              alignment: Alignment.topCenter,
              child: Opacity(
                opacity: 1.0 - percent,
                child:
                    _Image(coffe: coffes[(currentIndex - 2) % coffes.length]),
              ),
            ),

            //second
            Transform.translate(
              offset: Offset(0, lerpDouble(height * 0.1, 0.0, percent)!),
              child: Transform.scale(
                scale: lerpDouble(0.6, 0.3, percent),
                alignment: Alignment.topCenter,
                child:
                    _Image(coffe: coffes[(currentIndex - 1) % coffes.length]),
              ),
            ),

            //first
            Transform.translate(
              offset:
                  Offset(0, lerpDouble(height * 0.25, height * 0.1, percent)!),
              child: Transform.scale(
                scale: lerpDouble(1.0, 0.6, percent),
                alignment: Alignment.topCenter,
                child: _Image(coffe: coffes[currentIndex % coffes.length]),
              ),
            ),

            //hidden
            Transform.translate(
              offset:
                  Offset(0, lerpDouble(height * 1.5, height * 0.25, percent)!),
              child: Transform.scale(
                scale: lerpDouble(2.0, 1.0, percent),
                alignment: Alignment.topCenter,
                child:
                    _Image(coffe: coffes[(currentIndex + 1) % coffes.length]),
              ),
            ),
          ],
        );
      }
      return Stack(
        alignment: Alignment.center,
        children: [
          //three
          if (currentIndex > 1)
            Transform.scale(
              scale: lerpDouble(0.3, 0, percent),
              alignment: Alignment.topCenter,
              child: Opacity(
                opacity: 1.0 - percent,
                child:
                    _Image(coffe: coffes[(currentIndex - 2) % coffes.length]),
              ),
            ),

          //second
          if (currentIndex > 0)
            Transform.translate(
              offset: Offset(0, lerpDouble(height * 0.1, 0.0, percent)!),
              child: Transform.scale(
                scale: lerpDouble(0.6, 0.3, percent),
                alignment: Alignment.topCenter,
                child:
                    _Image(coffe: coffes[(currentIndex - 1) % coffes.length]),
              ),
            ),

          //first
          Transform.translate(
            offset:
                Offset(0, lerpDouble(height * 0.25, height * 0.1, percent)!),
            child: Transform.scale(
              scale: lerpDouble(1.0, 0.6, percent),
              alignment: Alignment.topCenter,
              child: _Image(coffe: coffes[currentIndex % coffes.length]),
            ),
          ),

          //hidden
          if (currentIndex < coffes.length - 1)
            Transform.translate(
              offset:
                  Offset(0, lerpDouble(height * 1.5, height * 0.25, percent)!),
              child: Transform.scale(
                scale: lerpDouble(2.0, 1.0, percent),
                alignment: Alignment.topCenter,
                child:
                    _Image(coffe: coffes[(currentIndex + 1) % coffes.length]),
              ),
            ),
        ],
      );
    });
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.coffe,
  });

  final CoffeeModel coffe;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Image.asset(
          coffe.imagePath,
          // fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 228, 142, 45),
            Colors.transparent,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0.1, 0.4],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.item,
  });

  final CoffeeModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          item.coffeName,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${item.price}',
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
