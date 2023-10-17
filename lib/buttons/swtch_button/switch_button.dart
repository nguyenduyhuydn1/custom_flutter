import 'package:custom_flutter/buttons/lite_rolling_switch.dart';
import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({super.key});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LiteRollingSwitch(
          onTap: () {},
          onDoubleTap: () {},
          onSwipe: () {},
          //initial value
          value: true,
          textOn: 'disponible',
          textOff: 'ocupado',
          colorOn: Colors.greenAccent[700]!,
          colorOff: Colors.redAccent[700]!,
          iconOn: Icons.done,
          iconOff: Icons.remove_circle_outline,
          textSize: 16.0,
          onChanged: (bool state) {
            //Use it to manage the different states
            // print('Current State of SWITCH IS: $state');
          },
        ),
      ),
    );
  }
}
