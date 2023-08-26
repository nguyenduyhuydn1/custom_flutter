import 'package:flutter/material.dart';

// pageview_bottom_navigation_bar
class PageViewBottomNavigationBar extends StatefulWidget {
  const PageViewBottomNavigationBar({super.key});

  @override
  State<PageViewBottomNavigationBar> createState() =>
      _PageViewBottomNavigationBarState();
}

class _PageViewBottomNavigationBarState
    extends State<PageViewBottomNavigationBar> {
  int currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  final List<Widget> _pages = const [
    // ProductView(),
    // CategoryView(),
    // CartView(),
    Text("data"),
    Text("data"),
    Text("data"),
    Text("data"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) => _pages[index],
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: _NavigationBottomBar(
                onpressed: (i) {
                  _pageController.jumpToPage(i);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _NavigationBottomBar extends StatelessWidget {
  final Function(int) onpressed;
  const _NavigationBottomBar({required this.onpressed});

  @override
  Widget build(BuildContext context) {
    const List<IconData> icons = [
      Icons.home,
      Icons.category,
      Icons.shopping_cart,
      Icons.person,
    ];

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...icons
              .asMap()
              .map(
                (i, e) => MapEntry(
                  i,
                  IconButton(
                    onPressed: () => onpressed(i),
                    icon: Icon(
                      e,
                      color: Colors.white60,
                      size: 30,
                    ),
                  ),
                ),
              )
              .values
              .toList()
        ],
      ),
    );
  }
}
