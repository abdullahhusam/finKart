import 'package:finkart/features/orders/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../repo/order_repo.dart';

class OrderDetailsViewModel extends ChangeNotifier {
  Order? _selectedOrder;

  Order? get selectedOrder => _selectedOrder;

  void setSelectedOrder(Order order) {
    _selectedOrder = order;
    notifyListeners();
  }

  void clearSelectedOrder() {
    _selectedOrder = null;
    notifyListeners();
  }
}
