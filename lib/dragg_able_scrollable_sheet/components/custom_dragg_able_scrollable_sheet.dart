import 'package:flutter/material.dart';

class CustomDraggableScrollableSheet extends StatefulWidget {
  const CustomDraggableScrollableSheet({super.key});

  @override
  State<CustomDraggableScrollableSheet> createState() =>
      _CustomDraggableScrollableSheetState();
}

class _CustomDraggableScrollableSheetState
    extends State<CustomDraggableScrollableSheet> {
  double _percent = 0.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            bottom: size.height * 0.3,
            child: Container(
              color: Colors.red,
            ),
          ),
          Positioned(
            left: 20,
            top: 20,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.white,
              elevation: 10,
              child: const Icon(Icons.menu, color: Colors.black),
            ),
          ),
          Positioned.fill(
            child: NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                final percent = 2 * notification.extent - 0.8;

                //maxChildSize = 0.9
                //x = 1
                // ---------------
                // maxChildSize - 0.4 = x - 0
                // 0.9 - 0.4 = 1 - 0
                // 0.5 = x

                // x = 2*0.5 - 0.8

                setState(() {
                  _percent = percent;
                });
                return true;
              },
              child: DraggableScrollableSheet(
                maxChildSize: 0.9,
                minChildSize: 0.4,
                initialChildSize: 0.4,
                builder: (context, scrollController) {
                  return Container(
                    color: Colors.black,
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            'index - $index',
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned.fill(
            top: -170 * (1 - _percent),
            bottom: null,
            child: const Material(
              elevation: 10,
              color: Colors.blue,
              child: Column(
                children: [
                  Text("xxxxxxxxxxxxxxxxxxx"),
                  Text("data1"),
                  Text("data2"),
                  Text("data3"),
                  // Text("data4"),
                  // Text("data5"),
                  // Text("data"),
                  // Text("data"),
                  // Text("data"),
                  // Text("data"),
                  // Text("data"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
