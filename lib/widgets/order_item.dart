import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/order.dart';

class OrderItem extends StatelessWidget {
  const OrderItem(this.order, {Key? key}) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle:
                Text(DateFormat('dd/MM/yyyy hh:mm').format(order.dateTime)),
            trailing:
                IconButton(onPressed: () {}, icon: const Icon(Icons.expand_more)),
          ),
        ],
      ),
    );
  }
}
