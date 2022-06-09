import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/order.dart';

class OrderItem extends StatefulWidget {
  const OrderItem(this.order, {Key? key}) : super(key: key);
  final OrderModel order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '\$${widget.order.amount}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            ),
          ),
          if (_expanded)
            Container(
              height: min(widget.order.products.length * 20.0 + 100, 100),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: ListView(
                children: [
                  ...widget.order.products.map(
                    (product) => Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Text(
                            product.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Text(
                            '${product.quantity}x \$${product.price}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
