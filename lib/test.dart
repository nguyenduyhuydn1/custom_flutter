import 'package:animate_do/animate_do.dart';
import 'package:custom_flutter/testModel/home_page.dart';
import 'package:flutter/material.dart';

class Test2 extends StatelessWidget {
  const Test2({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInRight(child: const HomePage());
  }
}
