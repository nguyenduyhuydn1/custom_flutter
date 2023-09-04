import 'package:custom_flutter/page_transition/widgets/page_transition.dart';
import 'package:flutter/material.dart';

class Pagetransitionapp extends StatefulWidget {
  const Pagetransitionapp({super.key});

  @override
  State<Pagetransitionapp> createState() => _PagetransitionappState();
}

class _PagetransitionappState extends State<Pagetransitionapp>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 33, 118, 216)),
        ),
        title: const Text(
          'Page Transition',
          style: TextStyle(
              color: Color.fromARGB(255, 236, 229, 229),
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          custombutton(() {
            Navigator.push(
                context, SlidePageTransition(secondpage: const Deviceinfo()));
          }, Colors.red, 'Slide Transition'),
          custombutton(() {
            Navigator.push(
                context, ScalePageTransition(secondpage: const Deviceinfo()));
          }, Colors.blue, 'Scale Transition'),
          custombutton(() {
            Navigator.push(
                context, SizePageTransition(secondpage: const Deviceinfo()));
          }, Colors.orange, 'Size Transition'),
          custombutton(() {
            Navigator.push(
                context, FadePageTransition(secondpage: const Deviceinfo()));
          }, Colors.grey, 'Fade Transition'),
          custombutton(() {
            Navigator.push(
                context, RotatePageTransition(secondpage: const Deviceinfo()));
          }, Colors.teal, 'Rotate Transition'),
          // custombutton(() {
          //   Navigator.push(
          //       context,
          //       PageTransition(
          //           alignment: Alignment.center,
          //           duration: const Duration(seconds: 3),
          //           reverseDuration: const Duration(seconds: 3),
          //           curve: Curves.easeInOutCirc,
          //           child: const Deviceinfo(),
          //           type: PageTransitionType.scale));
          // }, Colors.blueGrey, 'Custom Transition'),
        ]),
      ),
    );
  }

  MaterialButton custombutton(onpressed, Color color, String text) {
    return MaterialButton(
      onPressed: onpressed,
      color: color,
      child: Text(
        text,
        style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class Deviceinfo extends StatelessWidget {
  const Deviceinfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SizedBox(
        child: Center(
          child: Text("data"),
        ),
      ),
    );
  }
}
