import 'package:flutter/material.dart';

class ClickScroll extends StatefulWidget {
  const ClickScroll({super.key});

  @override
  State<ClickScroll> createState() => _ClickScrollState();
}

class _ClickScrollState extends State<ClickScroll> {
  final ScrollController scrollController = ScrollController();
  final ScrollController scrollController2 = ScrollController();

  late List<double> list = [];
  late List<double> list2 = [];
  bool uniqueTemp = true;
  bool uniqueTemp2 = true;

  int abc = 0;

  @override
  void initState() {
    super.initState();
    // scrollController2.addListener(() {
    //   print("object");
    //   scrollController.animateTo(
    //     list[1],
    //     duration: const Duration(seconds: 1),
    //     curve: Curves.bounceOut,
    //   );
    // });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   scrollController.animateTo(
    //     scrollController.position.,
    //     duration: const Duration(seconds: 1),
    //     curve: Curves.bounceOut,
    //   );
    // },);
  }

  @override
  void dispose() {
    scrollController.dispose();
    scrollController2.dispose();
    super.dispose();
  }

  final int number = 40;

  @override
  Widget build(BuildContext context) {
    print(list);
    print(list2);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(number, (index) {
                    return GetBoxOffset(
                      offset: (offset) {
                        if (uniqueTemp) {
                          list.add(offset.dx);
                          if (index == number - 1) {
                            uniqueTemp = false;
                          }
                          setState(() {});
                        }
                      },
                      child: FilledButton(
                        onPressed: () {
                          // SchedulerBinding.instance.addPostFrameCallback((_) {
                          //   scrollController.animateTo(
                          //     scrollController.position.maxScrollExteent,
                          //     duration: const Duration(seconds: 1),
                          //     curve: Curves.bounceOut,
                          //   );
                          // });
                          scrollController2.animateTo(
                            list2[index],
                            duration: const Duration(seconds: 1),
                            curve: Curves.bounceOut,
                          );
                        },
                        child: Text('$index - data - $index'),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController2,
                child: Column(
                  children: List.generate(number, (index) {
                    return GetBoxOffset(
                      offset: (offset) {
                        if (uniqueTemp2) {
                          list2.add(offset.dy - 200);
                          if (index == number - 1) {
                            uniqueTemp2 = false;
                          }
                          setState(() {});
                        }
                      },
                      child: Container(
                        color: Colors.white,
                        height: 80,
                        width: 80,
                        child: Text("index - $index"),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//get offset
class GetBoxOffset extends StatefulWidget {
  final Widget child;
  final Function(Offset offset) offset;

  const GetBoxOffset({
    Key? key,
    required this.child,
    required this.offset,
  }) : super(key: key);

  @override
  State<GetBoxOffset> createState() => _GetBoxOffsetState();
}

class _GetBoxOffsetState extends State<GetBoxOffset> {
  GlobalKey widgetKey = GlobalKey();

  late Offset offset;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = widgetKey.currentContext?.findRenderObject() as RenderBox;
      offset = box.localToGlobal(Offset.zero);
      widget.offset(offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: widgetKey,
      child: widget.child,
    );
  }
}
