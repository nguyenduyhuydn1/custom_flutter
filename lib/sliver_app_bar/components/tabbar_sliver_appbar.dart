import 'package:flutter/material.dart';

class TabbarSliverAppbar extends StatelessWidget {
  const TabbarSliverAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    List<Tab> icons = const [
      Tab(icon: Icon(Icons.search)),
      Tab(icon: Icon(Icons.favorite)),
      Tab(icon: Icon(Icons.arrow_back_ios)),
      Tab(icon: Icon(Icons.card_giftcard_outlined)),
    ];

    return DefaultTabController(
      length: icons.length,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.red,
              expandedHeight: MediaQuery.of(context).size.height * 0.5,
              leading: const Icon(Icons.arrow_back_ios),
              title: const Text("basic appbar"),
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://c4.wallpaperflare.com/wallpaper/53/304/933/fantasy-2560x1440-planet-hd-wallpaper-preview.jpg',
                  fit: BoxFit.cover,
                ),
                //handle img
                // collapseMode: CollapseMode.none,
                // title: const Text("title 2"),
                // centerTitle: true,
              ),
              actions: const [Icon(Icons.favorite_sharp), SizedBox(width: 10)],
              floating: true,
              // pinned: true,
              bottom: TabBar(
                tabs: [
                  ...List.generate(icons.length, (index) {
                    return icons[index];
                  })
                ],
              ),
            ),
          ];
        },
        body: const TabBarView(
          children: [
            SpaceWidget(color: Colors.orange),
            SpaceWidget(color: Colors.pink),
            SpaceWidget(color: Colors.amber),
            SpaceWidget(color: Colors.black),
          ],
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
