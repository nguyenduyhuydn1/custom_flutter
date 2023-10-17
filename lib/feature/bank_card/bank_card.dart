import 'package:flutter/material.dart';

class BankCard extends StatefulWidget {
  const BankCard({super.key});

  @override
  State<BankCard> createState() => _BankCardState();
}

class _BankCardState extends State<BankCard> {
  late PageController _pageCtl;
  double page = 1;
  double pageClamp = 1;
  double verPos = 0.0;
  late Size size;

  void pageControllerListener() {
    setState(() {
      page = _pageCtl.page!;
      pageClamp = page.clamp(0, 1);
    });
  }

  @override
  void initState() {
    _pageCtl = PageController(initialPage: 1, viewportFraction: 0.8);
    _pageCtl.addListener(pageControllerListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageCtl.removeListener(pageControllerListener);
    super.dispose();
  }

  void onVerticalDrad(DragUpdateDetails details) {
    setState(() {
      verPos += details.primaryDelta!;
      verPos = verPos.clamp(0, double.infinity);
    });
  }

  void onVerticalDradEnds(DragEndDetails details) {
    setState(() {
      if (details.primaryVelocity! > 500 || verPos > size.height / 2) {
        verPos = size.height - 40;
      }
      if (details.primaryVelocity! < -500 || verPos < size.height / 2) {
        verPos = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Add card background
          Positioned(
            top: pageClamp * size.height * .285 + verPos,
            bottom: pageClamp * size.height * .235 - verPos,
            left: pageClamp * size.width * .1,
            right: pageClamp * size.width * .2,
            child: Transform.translate(
              offset: Offset(
                page < 1 ? 0 : (-1 * page * size.width + size.width),
                0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(pageClamp * 20),
                ),
              ),
            ),
          ),

          // Add card
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: page < 0.3
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20 * 2),
                    child: _NumberCard(),
                  )
                : null,
          ),

          // page list
          Positioned(
            top: page == 0 ? 0 : (size.height * .25) + verPos,
            bottom: page == 0 ? 0 : size.height * .2 - verPos,
            left: 0,
            right: 0,
            child: PageView(
              controller: _pageCtl,
              children: List.generate(6, (index) {
                if (index == 0) return const SizedBox.shrink();

                return Transform.translate(
                  offset: Offset(
                    page < 1 ? (1 - pageClamp) * 50 : 0,
                    0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Container(color: Colors.green, height: 200),
                  ),
                );
              }),
            ),
          ),

          // Profile card
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            top: MediaQuery.of(context).padding.top - verPos,
            left: (size.width * .1 - verPos).clamp(0, double.infinity),
            right: (size.width * .1 - verPos).clamp(0, double.infinity),
            bottom: size.height * .75 - verPos,
            child: AnimatedSwitcher(
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              duration: const Duration(milliseconds: 150),
              child: pageClamp < .9
                  ? const SizedBox.shrink()
                  : GestureDetector(
                      onVerticalDragUpdate: onVerticalDrad,
                      onVerticalDragEnd: onVerticalDradEnds,
                      child: _ProfileSection(verticalPos: verPos),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NumberCard extends StatelessWidget {
  const _NumberCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(height: 80),
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
          const Text("data"),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              color: Colors.red,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  index = index + 1;
                  return Center(child: Text(index.toString()));
                },
                // crossAxisCount: 3,
                // children: [
                //   ...List.generate(9, (index) => index + 1).map(
                //     (e) => Center(child: Text(e.toString())),
                //   ),
                // ],
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("#"),
              Text("0"),
              Text("*"),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection({required this.verticalPos});
  final double verticalPos;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.blue,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("data"),
                CircleAvatar(backgroundColor: Colors.red)
              ],
            ),
          ),
          if (verticalPos > 250)
            // center is important, ignore drag when container full screen
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 800),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(backgroundColor: Colors.red),
                        CircleAvatar(backgroundColor: Colors.red),
                        CircleAvatar(backgroundColor: Colors.red),
                        CircleAvatar(backgroundColor: Colors.red),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(color: Colors.red, height: 100),
                    const SizedBox(height: 20),
                    Container(color: Colors.red, height: 100),
                    const SizedBox(height: 20),
                    Container(color: Colors.red, height: 100),
                    const SizedBox(height: 20),
                    Container(color: Colors.red, height: 100),
                    const SizedBox(height: 20),
                    Container(color: Colors.red, height: 100)
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
