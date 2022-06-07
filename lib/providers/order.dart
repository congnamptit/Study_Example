import 'package:flutter/foundation.dart';
import 'package:udemy_example/providers/cart.dart';

class OrderModel {
  final String id;
  final double amount;
  final List<CartModel> products;
  final DateTime dateTime;

  OrderModel({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  final List<OrderModel> _orders = [];

  List<OrderModel> get orders {
    return [..._orders];
  }

  void addOrder(List<CartModel> cartProducts, double total) {
    _orders.insert(
      0,
      OrderModel(
        id: DateTime.now().toString(),
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
