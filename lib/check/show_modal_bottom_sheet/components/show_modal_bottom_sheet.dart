import 'package:flutter/material.dart';

class Popover extends StatelessWidget {
  final Widget? child;
  const Popover({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(16),
      // clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          FractionallySizedBox(
            widthFactor: 0.25,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Container(
                height: 5,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: const BorderRadius.all(Radius.circular(2.5)),
                ),
              ),
            ),
          ),
          if (child != null) child!
        ],
      ),
    );
  }
}

class ShowModalBottomSheet extends StatefulWidget {
  const ShowModalBottomSheet({super.key});

  @override
  ShowModalBottomSheetState createState() => ShowModalBottomSheetState();
}

class ShowModalBottomSheetState extends State<ShowModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Custom Popover'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleFABPressed,
        child: const Icon(Icons.filter_alt_outlined),
      ),
    );
  }

  void _handleFABPressed() {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Popover(
          child: Column(
            children: [
              // _buildListItem(
              //   context,
              //   title: const Text('Total Task',
              //       style: TextStyle(color: Colors.red)),
              //   leading: const Icon(Icons.check_circle_outline),
              //   trailing: Switch(
              //     value: true,
              //     onChanged: (value) {},
              //   ),
              // ),
              // _buildListItem(
              //   context,
              //   title:
              //       const Text('Due Soon', style: TextStyle(color: Colors.red)),
              //   leading: const Icon(Icons.inbox),
              //   trailing: Switch(
              //     value: false,
              //     onChanged: (value) {},
              //   ),
              // ),
              // _buildListItem(
              //   context,
              //   title: const Text('Completed',
              //       style: TextStyle(color: Colors.red)),
              //   leading: const Icon(Icons.check_circle),
              //   trailing: Switch(
              //     value: false,
              //     onChanged: (value) {},
              //   ),
              // ),
              _buildListItem(
                context,
                title: const Text('Working On',
                    style: TextStyle(color: Colors.red)),
                leading: const Icon(Icons.flag),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListItem(
    BuildContext context, {
    Widget? title,
    Widget? leading,
    Widget? trailing,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.dividerColor, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          if (leading != null) leading,
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DefaultTextStyle(
                style: const TextStyle(fontSize: 16),
                child: title,
              ),
            ),
          const Spacer(),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}
