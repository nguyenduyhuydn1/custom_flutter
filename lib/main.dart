import 'package:custom_flutter/buttons/index.dart';
import 'package:custom_flutter/chat/chat.dart';
import 'package:custom_flutter/circular_progess/circular_progress.dart';
import 'package:custom_flutter/feature/index.dart';
import 'package:custom_flutter/search_delegate/custom_search_delegate.dart';
import 'package:custom_flutter/test.dart';
import 'package:custom_flutter/test2.dart';
import 'package:custom_flutter/time_line/index.dart';
import 'package:flutter/material.dart';

import 'package:custom_flutter/sliver_app_bar/index.dart';
import 'package:custom_flutter/bottom_navigation_bar/index.dart';
import 'package:custom_flutter/dragg_able_scrollable_sheet/index.dart';
import 'package:custom_flutter/page_transition/components/page_transition.dart';
import 'package:custom_flutter/check/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:custom_flutter/chip_button/chip_button.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const sliverAppBar = [
      AdvancedSliverAppbar(),
      BasicSliverAppBar(),
      TabbarSliverAppbar(),
    ];

    const pageTransition = [
      Pagetransitionapp(),
    ];

    const dragAbleScrollableSheet = [
      CustomDraggableScrollableSheet(),
    ];

    const bottomNavigationBar = [
      // AnimationBorderTopNavigation(),
      // AnimationNavigation(),
      // AnimationScale(),
      // BasicBottomNavigationBar(),
      // MultipleAnimation(),
      // PageViewBottomNavigationBar(),
      // TabBottonNavigationBar(),
      Bn1(),
      Bnb2(),
    ];

    /////////////////////////// check
    const listAnimation = [
      AnimationSlide(),
      // Card1(),
      // ShowModalBottomSheet(),
      // CustomTextFormField(),
    ];

    ///

    /////////////////////////// feature
    const feature = [
      ClickScroll(),
      ScrollMove(),
      AnimationCoffe(),
      Boats(),
      Pizza(),
      AnimationScroll3D(),
      ScrollRotateSwapPosition(),
      RotateNagativePage(),
      ScrollVerticalScale(),
      Tinder(),
      BankCard(),
      LimitDrag(),
      DragChange(),
      DragHorizontalMusic(),
    ];

    ///

    /////////////////////////// Chip Button, buttons and tabs
    const button = [
      ChipButton(),
      SwitchButton(),
      SwitchBtn2(),
      Tab2(),
      Tabs1(),
      Tabs2(),
    ];

    /////////////////////////// circular progess
    const circularProgess = [
      CustomCircularProgress(),
    ];

    /////////////////////////// timeLine
    const timeLine = [
      TimeLineHorizontal(),
      DelayUntilComplete(),
      TimeLine2(),
    ];

    /////////////////////////// search delegate
    final searchDelegate = [
      CustomSearchDelegate(),
    ];

    /////////////////////////// vhat
    final chat = [
      const Chat(),
    ];

    ///
    return MaterialApp(
      // showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const _DropDownButton(
                  listWidgets: sliverAppBar,
                  title: "Sliver App Bar",
                ),
                const _DropDownButton(
                  listWidgets: pageTransition,
                  title: "Page Transition",
                ),
                const _DropDownButton(
                  listWidgets: dragAbleScrollableSheet,
                  title: "Drag scroll sheet",
                ),
                const _DropDownButton(
                  listWidgets: bottomNavigationBar,
                  title: "Bottom Navigation Bar",
                ),
                const _DropDownButton(
                  listWidgets: listAnimation,
                  title: "Check",
                ),
                const _DropDownButton(
                  listWidgets: feature,
                  title: "feature",
                ),
                const _DropDownButton(
                  listWidgets: button,
                  title: "Button + tab",
                ),
                const _DropDownButton(
                  listWidgets: circularProgess,
                  title: "circular progess",
                ),
                const _DropDownButton(
                  listWidgets: timeLine,
                  title: "Time Line",
                ),
                _DropDownButton(
                  listWidgets: searchDelegate,
                  title: "search delegate",
                ),
                _DropDownButton(
                  listWidgets: chat,
                  title: "chat",
                ),
                Builder(
                  builder: (context) => FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Test1()),
                      );
                    },
                    child: const Text("test page"),
                  ),
                ),
                Builder(
                  builder: (context) => FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Test2()),
                      );
                    },
                    child: const Text("test page2"),
                  ),
                ),
                const Placeholder(),
                const Placeholder(),
                const Placeholder(),
                const Placeholder(),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: const Stack(),
      ),
    );
  }
}

class _DropDownButton extends StatelessWidget {
  const _DropDownButton({
    required this.listWidgets,
    required this.title,
  });

  final List<Widget> listWidgets;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.57),
              blurRadius: 2,
            )
          ],
        ),
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            //remove underline
            underline: Container(),
            hint: Text(title),
            dropdownColor: Colors.lightBlue,
            isExpanded: true,
            borderRadius: BorderRadius.circular(10),
            onChanged: (value) {},
            items: List.generate(listWidgets.length, (index) {
              final item = listWidgets[index];
              return DropdownMenuItem(
                value: item.toString(),
                child: Builder(
                  builder: (context) => FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => item),
                      );
                    },
                    child: Text(item.toString()),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
