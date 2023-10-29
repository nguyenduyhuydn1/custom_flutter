import 'package:flutter/material.dart';

class SwitchBtn2 extends StatelessWidget {
  const SwitchBtn2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DefaultTabController(
          length: 2,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: TabBar(
              indicator: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              labelStyle: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
              splashBorderRadius: BorderRadius.circular(20),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              tabs: const <Widget>[
                Text('My Country'),
                Text('Global'),
              ],
              onTap: (index) {},
            ),
          ),
        ),
      ),
    );
  }
}
