import 'package:flutter/material.dart';

class Tabs2 extends StatelessWidget {
  const Tabs2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: DefaultTabController(
          initialIndex: 4,
          length: 10,
          child: TabBar(
            // labelPadding: EdgeInsets.only(right: 20),
            // indicatorPadding: EdgeInsets.only(right: 20),
            labelPadding: EdgeInsets.only(right: 20, bottom: 20, left: 20),
            indicatorPadding: EdgeInsets.only(right: 40, left: 40),
            //
            isScrollable: true,
            labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.red,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 2,
                color: Colors.white,
              ),
            ),
            tabs: [
              Tab(icon: Icon(Icons.search), text: "asdasd"),
              Text('My Country'),
              Text('Global'),
              Text('Global'),
              Text('Global'),
              Text('My Country'),
              Text('Global'),
              Text('Global'),
              Text('Global'),
              Text('My Country'),
              Text('Global'),
              Text('Global'),
              Text('Global'),
            ],
          ),
        ),
      ),
    );
  }
}
