import 'package:flutter/material.dart';

class Tab2 extends StatefulWidget {
  const Tab2({super.key});

  @override
  State<Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Tab> icons = const [
    Tab(icon: Icon(Icons.search)),
    Tab(icon: Icon(Icons.favorite)),
    Tab(icon: Icon(Icons.arrow_back_ios)),
    Tab(icon: Icon(Icons.card_giftcard_outlined)),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 9);
  }

  int? _cachedFromIdx = 0;
  int? _cachedToIdx = 0;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 9,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                bottom: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 0,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  physics: const ClampingScrollPhysics(),
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.red,
                  labelPadding: const EdgeInsets.only(left: 12),
                  tabs: [
                    'Toàn Dân Chu',
                    'Toàn Dân Chu',
                    'Toàn Dân Chu',
                    'Toàn Dân Chu',
                    'Toàn Dân Chu',
                    'Toàn Dân Chu',
                    'Toàn Dân Chu',
                    'Toàn Dân Chu',
                    'Toàn Dân Chu'
                  ]
                      .asMap()
                      .entries
                      .map((entry) => AnimatedBuilder(
                            animation: _tabController,
                            builder: (ctx, snapshot) {
                              final forward = _tabController.offset > 0;
                              final backward = _tabController.offset < 0;
                              int? fromIndex;
                              int? toIndex;
                              double progress;

                              // This value is true during the [animateTo] animation that's triggered when the user taps a [TabBar] tab.
                              // It is false when [offset] is changing as a consequence of the user dragging the [TabBarView].
                              if (_tabController.indexIsChanging) {
                                fromIndex = _tabController.previousIndex;
                                toIndex = _tabController.index;
                                _cachedFromIdx = _tabController.previousIndex;
                                _cachedToIdx = _tabController.index;
                                progress = (_tabController.animation!.value -
                                            fromIndex)
                                        .abs() /
                                    (toIndex - fromIndex).abs();
                              } else {
                                if (_cachedFromIdx ==
                                        _tabController.previousIndex &&
                                    _cachedToIdx == _tabController.index) {
                                  // When user tap on a tab bar and the animation is completed, it will execute this block
                                  // This block will not be called when user draging the TabBarView
                                  fromIndex = _cachedFromIdx;
                                  toIndex = _cachedToIdx;
                                  progress = 1;
                                  _cachedToIdx = null;
                                  _cachedFromIdx = null;
                                } else {
                                  _cachedToIdx = null;
                                  _cachedFromIdx = null;
                                  fromIndex = _tabController.index;
                                  toIndex = forward
                                      ? fromIndex + 1
                                      : backward
                                          ? fromIndex - 1
                                          : fromIndex;
                                  progress = (_tabController.animation!.value -
                                          fromIndex)
                                      .abs();
                                }
                              }

                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: entry.key == fromIndex
                                      ? Color.lerp(Colors.white,
                                          Colors.red.shade900, progress)
                                      : entry.key == toIndex
                                          ? Color.lerp(Colors.red.shade900,
                                              Colors.white, progress)
                                          : Color.lerp(Colors.red.shade900,
                                              Colors.red.shade900, progress),
                                  borderRadius: BorderRadius.circular(200),
                                ),
                                child: Text(
                                  entry.value.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    letterSpacing: 0.4,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              );
                            },
                          ))
                      .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: const [
              SpaceWidget(color: Colors.orange),
              SpaceWidget(color: Colors.pink),
              SpaceWidget(color: Colors.amber),
              SpaceWidget(color: Colors.black),
              SpaceWidget(color: Colors.orange),
              SpaceWidget(color: Colors.pink),
              SpaceWidget(color: Colors.amber),
              SpaceWidget(color: Colors.black),
              SpaceWidget(color: Colors.pink),
            ],
          ),
        ),
      ),
    );
  }
}

class SpaceWidget extends StatelessWidget {
  final Color? color;
  const SpaceWidget({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(height: 200, color: color),
          const SizedBox(height: 800),
          Container(height: 200, color: Colors.red),
        ],
      ),
    );
  }
}
