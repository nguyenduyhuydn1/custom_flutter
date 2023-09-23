import 'package:custom_flutter/check/animation_coffe/models/coffee.dart';
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

  @override
  void initState() {
    _slidePageController = PageController(initialPage: _currentIndex);
    _titlePageController = PageController(initialPage: _currentIndex);

    _slidePageController.addListener(() {
      _currentIndex = _slidePageController.page!.floor();
      _percent = (_slidePageController.page! - _currentIndex).abs();
      print(_percent);
      _titlePageController.jumpTo(
          _slidePageController.page! * MediaQuery.of(context).size.width);
      setState(() {});
    });
    super.initState();
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
              itemCount: coffes.length,
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
                ),
                //details page
                PageView.builder(
                  controller: _slidePageController,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: coffes.length,
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
  });
  final int currentIndex;
  final double percent;
  final List<CoffeeModel> coffes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Positioned.fill(
            top: null,
            bottom: 500,
            child: Transform.scale(
              scale: 0.3,
              child: Image.asset(
                coffes[currentIndex].imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            top: null,
            bottom: 300,
            child: Transform.scale(
              scale: 0.4,
              child: Image.asset(
                coffes[currentIndex - 1].imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            top: null,
            bottom: -100,
            child: Transform.scale(
              scale: 0.7,
              child: Image.asset(
                coffes[currentIndex - 2].imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
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
