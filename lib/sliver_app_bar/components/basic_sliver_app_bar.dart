import 'package:flutter/material.dart';

import 'package:custom_flutter/sliver_app_bar/index.dart';

class BasicSliverAppBar extends StatelessWidget {
  const BasicSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.red,
          expandedHeight: MediaQuery.of(context).size.height * 0.5,
          leading: const Icon(Icons.arrow_back_ios),
          // title: const Text("basic appbar"),
          // centerTitle: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              'https://c4.wallpaperflare.com/wallpaper/53/304/933/fantasy-2560x1440-planet-hd-wallpaper-preview.jpg',
              fit: BoxFit.cover,
            ),
            //handle img
            // collapseMode: CollapseMode.none,
            title: const Text("title 2"),
            centerTitle: true,
          ),
          actions: const [Icon(Icons.favorite_sharp), SizedBox(width: 10)],
          // floating: true,
          pinned: true,
        ),
        const SpaceSliverToBox()
      ],
    );
  }
}
