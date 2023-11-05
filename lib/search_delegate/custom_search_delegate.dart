import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomSearchDelegate extends StatefulWidget {
  CustomSearchDelegate({super.key}) {
    print("object");
  }

  @override
  State<CustomSearchDelegate> createState() => _CustomSearchDelegateState();
}

class _CustomSearchDelegateState extends State<CustomSearchDelegate> {
  @override
  void initState() {
    print("init");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      print("SchedulerBinding");
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("init2");
      showSearch(
        // query: searchedProduct,
        context: context,
        delegate: SearchProductDelegates(
            // searchQuery: ref.read(searchProvider.notifier).searchProductByTerm,
            // initialProducts: searchQuery,
            ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(mounted);
    return GestureDetector(
      onTap: () {
        // FocusScope.of(context).requestFocus();
        // FocusScope.of(context).unfocus();
        // https://www.youtube.com/watch?v=2ikQj5MUzZA
        showSearch(
          // query: searchedProduct,
          context: context,
          delegate: SearchProductDelegates(
              // searchQuery: ref.read(searchProvider.notifier).searchProductByTerm,
              // initialProducts: searchQuery,
              ),
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}

class SearchProductDelegates extends SearchDelegate {
  SearchProductDelegates()
      : super(
          searchFieldLabel: "Search Product",
          // textInputAction: TextInputAction.done,
          searchFieldStyle: const TextStyle(color: Colors.red),
          // searchFieldDecorationTheme: InputDecorationTheme(
          //   alignLabelWithHint: true,
          //   outlineBorder: const BorderSide(color: Colors.red, width: 1),
          //   activeIndicatorBorder:
          //       const BorderSide(color: Colors.red, width: 1),
          //   border: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(20),
          //     borderSide: const BorderSide(
          //       color: Colors.red,
          //     ),
          //   ),
          //   focusedBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(20),
          //     borderSide: const BorderSide(
          //       color: Colors.red,
          //     ),
          //   ),
          // ),
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        // filled: true,
        // isDense: true,
        floatingLabelAlignment: FloatingLabelAlignment.center,
        constraints: const BoxConstraints(maxHeight: 100, maxWidth: 200),
        suffixIconColor: Colors.orange,
        prefixIconColor: Colors.orange,
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(520),
          ),
        ),
      ),
      appBarTheme: theme.appBarTheme.copyWith(
        color: Colors.transparent,
        toolbarHeight: 300.0,
        toolbarTextStyle: const TextStyle(color: Colors.red, fontSize: 12),
        elevation: 0,
        titleSpacing: 0,
      ),
    );
  }

  Widget buildResultsAndSuggestions() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => const _ProductItem(),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      const Text("data111111111111111"),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back_ios_new_outlined,
        color: Colors.red,
      ),
    );
    // return const SizedBox.shrink();
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResultsAndSuggestions();
  }
}

class _ProductItem extends StatelessWidget {
  const _ProductItem();

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 10),
            //text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "xxxx".toUpperCase(),
                      style: textStyle.titleMedium?.copyWith(
                        fontSize: 15,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
