import 'package:flutter/material.dart';

class OrderStatusItemView extends StatelessWidget {
  const OrderStatusItemView(
      {Key? key,
      required this.color,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.showLine,
      required this.isActive})
      : super(key: key);
  final Color color;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool showLine;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;

    return Opacity(
      opacity: isActive ? 1 : 0.3,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      //color: color,
                      border: Border.all(
                        color: isActive ? color : Colors.grey,
                      ),
                    ),
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive ? color : Colors.grey,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: showLine,
                    child: Expanded(
                      child: CustomPaint(
                        painter: DashedLinePainter(
                            color: isActive ? color : Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Card(
                color: themeColors.surface,
                child: ListTile(
                  title: Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  trailing: Icon(
                    icon,
                    color: isActive ? color : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  final bool isVertical;

  DashedLinePainter({this.color = Colors.blueGrey, this.isVertical = true});
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 9, dashSpace = 5, startX = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    if (isVertical) {
      while (startX < size.height) {
        canvas.drawLine(
            Offset(0, startX), Offset(0, startX + dashWidth), paint);
        startX += dashWidth + dashSpace;
      }
    } else {
      while (startX < size.width) {
        canvas.drawLine(
            Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
        startX += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
