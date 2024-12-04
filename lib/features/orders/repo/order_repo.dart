import 'dart:convert';
import 'package:finkart/features/orders/models/order_model.dart';
import 'package:flutter/services.dart';

class OrdersRepository {
  Future<List<Order>> fetchOrders() async {
    final String response = await rootBundle.loadString('assets/orders.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Order.fromJson(json)).toList();
  }
}
