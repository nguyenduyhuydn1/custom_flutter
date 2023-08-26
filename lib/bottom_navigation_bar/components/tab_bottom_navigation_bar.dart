import 'package:flutter/material.dart';

class TabBottonNavigationBar extends StatefulWidget {
  const TabBottonNavigationBar({super.key});

  @override
  State<TabBottonNavigationBar> createState() => _TabBottonNavigationBarState();
}

class _TabBottonNavigationBarState extends State<TabBottonNavigationBar> {
  int pageIndex = 0;
  final List<IconData> icons = const [
    Icons.home,
    Icons.favorite_outline,
    Icons.shopping_cart_outlined,
    Icons.person_2_rounded,
  ];

  final List<Widget> viewRoutes = const [
    Text("data"),
    Text("data"),
    Text("data"),
    Text("data"),
  ];

  final List<Widget> viewRoutesAdim = const [
    Text("data"),
    Text("data"),
    Text("data"),
    Text("data"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: icons.length,
      child: Scaffold(
        body: IndexedStack(
          index: pageIndex,
          children: viewRoutes,
        ),
        bottomNavigationBar: CustomBottomNavigation(
          icons: icons,
          pageIndex: pageIndex,
          onPressed: (index) => setState(() => pageIndex = index),
        ),
      ),
    );
  }
}

class CustomBottomNavigation extends StatelessWidget {
  final int pageIndex;
  final List<IconData> icons;
  final Function(int) onPressed;

  const CustomBottomNavigation({
    super.key,
    required this.onPressed,
    required this.pageIndex,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      splashFactory: NoSplash.splashFactory,
      indicator: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.green,
            width: 3.0,
          ),
        ),
      ),
      tabs: icons
          .asMap()
          .map((i, e) => MapEntry(
                i,
                Tab(
                  icon: Icon(
                    e,
                    color: i == pageIndex ? Colors.green : Colors.black45,
                    size: 30.0,
                  ),
                ),
              ))
          .values
          .toList(),
      onTap: onPressed,
    );
  }
}
