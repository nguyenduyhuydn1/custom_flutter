import 'package:flutter/material.dart';

class BasicBottomNavigationBar extends StatefulWidget {
  const BasicBottomNavigationBar({super.key});

  @override
  State<BasicBottomNavigationBar> createState() =>
      _BasicBottomNavigationBarState();
}

class _BasicBottomNavigationBarState extends State<BasicBottomNavigationBar> {
  int _pageIndex = 0;

  void _handlePressed(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  final List<Widget> viewRoutes = const [
    // HomeView(),
    // TabbarSliverAppbar(),
    // AdvancedSliverAppbar(),
    Text("data"),
    Text("data"),
    Text("data"),
    Text("data"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _pageIndex,
        children: viewRoutes,
      ),
      // remove click effect splash
      // https://stackoverflow.com/questions/55949824/how-to-make-bottomnavigationbaritem-not-clickable-and-disable-tap-splash-effect
      bottomNavigationBar: CustomBottomNavigationBar(
        pageIndex: _pageIndex,
        onPressed: _handlePressed,
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final Function(int) onPressed;
  final int pageIndex;

  const CustomBottomNavigationBar({
    super.key,
    required this.pageIndex,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      //no splash
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: onPressed,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        elevation: 0,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.label_outline),
            label: 'Categorías',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_sharp),
            label: 'Photo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'zxc',
          ),
        ],
      ),
    );
  }
}
