import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_example/providers/cart.dart';

import '../providers/order.dart';
import '../widgets/card_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routerName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .subtitle1
                              ?.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount,
                      );
                      cart.clear();
                    },
                    child: const Text('ORDER NOW'),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) {
                final carts = cart.items;
                return carts.isNotEmpty
                    ? CartItem(
                        carts.values.toList()[i].id,
                        cart.items.keys.toList()[i],
                        carts.values.toList()[i].title,
                        carts.values.toList()[i].price,
                        carts.values.toList()[i].quantity,
                      )
                    : const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
