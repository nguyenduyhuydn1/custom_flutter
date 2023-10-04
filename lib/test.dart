import 'package:flutter/material.dart';

class M3 {
  final bool isSelected;
  final Color color;

  M3({required this.isSelected, required this.color});

  M3 copyWith({
    Color? color,
    bool? isSelected,
  }) =>
      M3(
        color: color ?? this.color,
        isSelected: isSelected ?? this.isSelected,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is M3 &&
          runtimeType == other.runtimeType &&
          isSelected == other.isSelected &&
          color == other.color;

  @override
  int get hashCode => Object.hash(color, isSelected);

  // int get hashCode => color.hashCode ^ isSelected.hashCode;
}

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late ScrollController scrollController;

  List<M3> dataM3 = [
    M3(isSelected: false, color: Colors.red),
    M3(isSelected: false, color: Colors.blue),
    M3(isSelected: false, color: Colors.green),
    M3(isSelected: false, color: Colors.amber),
  ];

  double percent = 0;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      // dataM3.addAll(List.from(dataM3.sublist(0, 3)));
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(controller: scrollController, slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = dataM3[index % dataM3.length];
                const double height = 200;
                final bool isEven = index % 2 == 0;

                // percent vertical
                final itemPositionOffset = index * height / 2;
                final difference = scrollController.offset - itemPositionOffset;
                final percent = 1 - (difference / (height / 2));

                return Align(
                  heightFactor: 0.5,
                  child: Opacity(
                    opacity: percent.clamp(0.0, 1.0),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..scale(percent.clamp(0.0, 1.0)),
                      child: Container(
                        height: height,
                        decoration: BoxDecoration(
                          color: item.color,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: -50,
                              right: isEven ? 10 : null,
                              child: Image.network(
                                'https://picsum.photos/500',
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ]),
        ),
      ),
    );
  }
}
