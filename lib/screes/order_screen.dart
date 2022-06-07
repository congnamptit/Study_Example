import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_example/providers/order.dart';
import 'package:udemy_example/widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Order'),
      ),
      body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (ctx, i) {
            return OrderItem(orderData.orders[i]);
          }),
    );
  }
}
