import 'package:custom_flutter/check/animation_coffe/models/coffee.dart';
import 'package:flutter/material.dart';

class AnimationCoffe extends StatefulWidget {
  const AnimationCoffe({super.key});

  @override
  State<AnimationCoffe> createState() => _AnimationCoffeState();
}

class _AnimationCoffeState extends State<AnimationCoffe> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * .15,
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: coffes.length,
              itemBuilder: (context, index) {
                final item = coffes[index];
                return _Title(item: item);
              },
            ),
          ),
          const Expanded(
            child: Stack(
              children: [
                Positioned.fill(child: _Background()),
              ],
            ),
          )
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
