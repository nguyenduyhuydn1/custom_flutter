import 'package:custom_flutter/sliver_app_bar/index.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation_bar/index.dart';
import 'check/index.dart';
import 'dragg_able_scrollable_sheet/index.dart';
import 'page_transition/components/page_transition.dart';

void main() {
  runApp(const MainApp());
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
      AnimationBorderTopNavigation(),
      AnimationNavigation(),
      AnimationScale(),
      BasicBottomNavigationBar(),
      MultipleAnimation(),
      PageViewBottomNavigationBar(),
      TabBottonNavigationBar(),
    ];

    /////////////////////////// check
    const listAnimation = [
      AnimationCoffe(),
      AnimationSlide(),
      Card1(),
      ShowModalBottomSheet(),
      CustomTextFormField(),
    ];

    ///

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            _DropDownButton(listWidgets: sliverAppBar, title: "Sliver App Bar"),
            _DropDownButton(
              listWidgets: pageTransition,
              title: "Page Transition",
            ),
            _DropDownButton(
              listWidgets: dragAbleScrollableSheet,
              title: "Drag scroll sheet",
            ),
            _DropDownButton(
              listWidgets: bottomNavigationBar,
              title: "Bottom Navigation Bar",
            ),
            _DropDownButton(
              listWidgets: listAnimation,
              title: "Check",
            ),
          ],
        ),
      )),
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
