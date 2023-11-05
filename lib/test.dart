import 'package:flutter/material.dart';

class Test1 extends StatefulWidget {
  const Test1({super.key});

  @override
  State<Test1> createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  bool check = false;
  final List<Item> data = [
    Item(text: "111111", expanText: "2222222222"),
    Item(text: "111111", expanText: "2222222222"),
    Item(text: "111111", expanText: "2222222222"),
    Item(text: "111111", expanText: "2222222222"),
    Item(text: "111111", expanText: "2222222222"),
    Item(text: "111111", expanText: "2222222222"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black45,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: ExpansionPanelList(
              // animationDuration: const Duration(milliseconds: 500),
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  data[panelIndex].isExpand = !isExpanded;
                });
              },
              children: data.map((e) {
                return ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(title: Text(e.text));
                  },
                  body: ListTile(
                    title: Text(
                      e.expanText,
                      style: const TextStyle(color: Colors.red),
                    ),
                    // onTap: () {
                    //   setState(() {
                    //     data.removeWhere((element) => e == element);
                    //   });
                    // },
                  ),
                  isExpanded: true,
                );
              }).toList(),
            ),
          ),
        )
        // Center(
        //   child: InkWell(
        //     splashColor: Colors.red,
        //     onTap: () {
        //       check = !check;
        //     },
        //     child: Container(
        //       // duration: const Duration(milliseconds: 1),
        //       width: 100,
        //       height: 100,
        //       alignment: Alignment.center,
        //       decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.circular(13),
        //         border: Border.all(
        //           width: 1,
        //           color: Colors.red,
        //         ),
        //       ),
        //       child: const Text("data"),
        //     ),
        //   ),
        // ),
        );
  }
}

class Item {
  final String text;
  final String expanText;
  bool isExpand;

  Item({required this.text, required this.expanText, this.isExpand = false});
}
