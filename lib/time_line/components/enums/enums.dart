import 'package:custom_flutter/time_line/components/enums/order_status_item_view.dart';
import 'package:flutter/material.dart';

class Enums extends StatefulWidget {
  const Enums({Key? key}) : super(key: key);

  @override
  State<Enums> createState() => _EnumsState();
}

class _EnumsState extends State<Enums> {
  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    MyOrder order = MyOrder.order.copyWith(status: OrderStatusEnum.delivered);

    return Scaffold(
      backgroundColor: themeColors.background,
      appBar: AppBar(
        elevation: 0,
        title: Column(
          children: [
            const Text('Order tracking'),
            Text(
              '#${order.orderId}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 48,
          bottom: 16,
        ),
        children: [
          ...OrderStatusEnum.values
              .asMap()
              .map(
                (i, e) => MapEntry(
                  i,
                  OrderStatusItemView(
                    color: e.color,
                    title: e.title,
                    subtitle: e.description,
                    icon: e.icon,
                    showLine: i < OrderStatusEnum.values.length - 1,
                    isActive: i < 2,
                    // isActive: OrderStatusEnum.values.indexOf(order.status) >= i,
                  ),
                ),
              )
              .values
              .toList()
        ],
      ),
    );
  }
}

class MyOrder {
  final String orderId;
  final OrderStatusEnum status;

  MyOrder(this.orderId, this.status);

  static MyOrder get order {
    return MyOrder('ORDR123', OrderStatusEnum.processing);
  }

  MyOrder copyWith({
    String? orderId,
    OrderStatusEnum? status,
  }) {
    return MyOrder(
      orderId ?? this.orderId,
      status ?? this.status,
    );
  }
}

enum OrderStatusEnum {
  processing(
    color: Colors.amber,
    title: 'Processing',
    description: 'Your order is being processed.',
    icon: Icons.hourglass_top_outlined,
  ),
  packaging(
    color: Colors.indigo,
    title: 'Packaging',
    description: 'Your order is being packaged.',
    icon: Icons.touch_app,
  ),
  inTransit(
    color: Colors.blue,
    title: 'In Transit',
    description: 'Your order is on it\'s way to you.',
    icon: Icons.local_shipping_outlined,
  ),
  delivered(
    color: Colors.green,
    title: 'Delivered',
    description: 'Thank you for shopping with us.',
    icon: Icons.task_alt_outlined,
  );

  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const OrderStatusEnum({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  String get humanReadableName {
    switch (this) {
      case OrderStatusEnum.processing:
        return 'Processing';
      case OrderStatusEnum.inTransit:
        return 'In Transit';
      case OrderStatusEnum.delivered:
        return 'Delivered';
      case OrderStatusEnum.packaging:
        return 'Packaging';
    }
  }
}
