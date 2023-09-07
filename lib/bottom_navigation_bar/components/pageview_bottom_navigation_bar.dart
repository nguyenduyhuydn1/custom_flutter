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
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(keepPage: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = const [
    Text("data"),
    Text("xx"),
    Text("xccc"),
    Text("aasd"),
  ];

  @override
  Widget build(BuildContext context) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        currentIndex,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 250),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              // onPageChanged: (value) {
              //   setState(() {
              //     currentIndex = value;
              //   });
              // },
              itemCount: _pages.length,
              itemBuilder: (context, index) => _pages[index],
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: _NavigationBottomBar(
                onpressed: (i) {
                  setState(() {
                    currentIndex = i;
                  });
                  // _pageController.jumpToPage(i);
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
      Icons.favorite,
      // Icons.person,
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
                  // IconButton(
                  //   onPressed: () => onpressed(i),
                  //   icon: Icon(
                  //     e,
                  //     color: Colors.white60,
                  //     size: 30,
                  //   ),
                  // ),

                  Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                      onTap: () => onpressed(i),
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          e,
                          color: Colors.white60,
                          size: 30,
                        ),
                      ),
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
