import 'package:custom_flutter/feature/bank_card/test_root/bank_card_model.dart';
import 'package:custom_flutter/feature/bank_card/test_root/constants.dart';
import 'package:custom_flutter/feature/bank_card/test_root/widgets/add_card.dart';
import 'package:custom_flutter/feature/bank_card/test_root/widgets/bank_card.dart';
import 'package:custom_flutter/feature/bank_card/test_root/widgets/profile_section.dart';
import 'package:flutter/material.dart';

class Test1 extends StatefulWidget {
  const Test1({Key? key}) : super(key: key);

  @override
  Test1State createState() => Test1State();
}

class Test1State extends State<Test1> {
  final PageController _pg = PageController(
    viewportFraction: .8,
    initialPage: 1,
  );

  double page = 1;
  double pageClamp = 1;

  late Size size;

  double verPos = 0.0;

  Duration defaultDuration = const Duration(milliseconds: 300);

  void pageListener() {
    setState(() {
      page = _pg.page!;
      pageClamp = page.clamp(0, 1);
    });
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
  void initState() {
    _pg.addListener(pageListener);
    super.initState();
  }

  @override
  void dispose() {
    _pg.removeListener(pageListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Add card background
          Positioned(
            top: pageClamp * size.height * .275 + verPos,
            bottom: pageClamp * size.height * .225 - verPos,
            left: pageClamp * size.width * .1,
            right: pageClamp * size.width * .2,
            child: Transform.translate(
              offset: Offset(
                page < 1 ? 0 : (-1 * page * size.width + size.width),
                0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(
                    pageClamp * Constants.radius,
                  ),
                ),
              ),
            ),
          ),
          // Add card
          AnimatedSwitcher(
            duration: defaultDuration,
            child: page < 0.3
                ? const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Constants.padding * 2,
                    ),
                    child: AddCard(),
                  )
                : null,
          ),
          // cards list
          Positioned(
            top: page == 0 ? 0 : (size.height * .25) + verPos,
            bottom: page == 0 ? 0 : size.height * .2 - verPos,
            left: 0,
            right: 0,
            child: PageView(
              controller: _pg,
              children: List.generate(cards.length, (index) {
                final item = cards[index];

                if (item == null) return const SizedBox.shrink();

                return Transform.translate(
                  offset: Offset(
                    page < 1 ? (1 - pageClamp) * 50 : 0,
                    0,
                  ),
                  child: BankCard(bankCard: item),
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
            // bottom: size.height * .75 - verPos,
            child: AnimatedSwitcher(
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              duration: const Duration(milliseconds: 150),
              child: pageClamp < .9
                  ? const SizedBox.shrink()
                  : GestureDetector(
                      onVerticalDragUpdate: onVerticalDrad,
                      onVerticalDragEnd: onVerticalDradEnds,
                      child: ProfileSection(
                        verticalPos: verPos,
                      ),
                    ),
            ),
          ),

          Positioned(
            top: size.height * .85 + verPos,
            left: size.width * .1,
            right: size.width * .1,
            child: AnimatedSwitcher(
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              duration: const Duration(milliseconds: 100),
              child: pageClamp < .9
                  ? const SizedBox.shrink()
                  : TweenAnimationBuilder(
                      key: Key(cards[page.round()]!.expenses.first.description),
                      tween: Tween<double>(begin: 25.0, end: 0),
                      duration: const Duration(milliseconds: 200),
                      builder: (context, double value, _) {
                        return Transform.translate(
                          offset: Offset(0, value),
                          child: ListTile(
                            leading: CircleAvatar(
                              foregroundImage: AssetImage(
                                cards[page.round()]!.expenses.first.image,
                              ),
                            ),
                            title: Text(
                              cards[page.round()]!.expenses.first.title,
                            ),
                            subtitle: Text(
                              cards[page.round()]!.expenses.first.description,
                            ),
                            trailing: Text(
                              "-\$${cards[page.round()]!.expenses.first.amount.toStringAsFixed(2)}",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}
