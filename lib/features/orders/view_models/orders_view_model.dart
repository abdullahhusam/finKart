import 'package:finkart/features/orders/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../repo/order_repo.dart';

class OrdersViewModel extends ChangeNotifier {
  OrdersViewModel(this._repository) {
    loadOrders();
    loadOrdersByDate();
  }
  final OrdersRepository _repository;
  Map<String, int> _ordersByDate = {};
  List<Order> _orders = [];
  int _currentPage = 1;
  final int _pageSize = 10;
  bool _isLoading = false;
  bool _hasMore = true;

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Map<String, int> get ordersByDate => _ordersByDate;

  Future<void> loadOrdersByDate() async {
    final orders = await _repository.fetchOrders();

    // Group orders by date
    final Map<String, int> ordersByDate = {};
    for (var order in orders) {
      final date = DateFormat('yyyy-MM-dd').format(order.registered);
      ordersByDate[date] = (ordersByDate[date] ?? 0) + 1;
    }

    // Sort the orders by date
    final sortedOrders = Map.fromEntries(
      ordersByDate.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );

    _ordersByDate = sortedOrders;
    notifyListeners();
  }

  Future<void> loadOrders() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      final allOrders = await _repository.fetchOrders();

      // Simulate pagination
      final startIndex = (_currentPage - 1) * _pageSize;
      final endIndex = startIndex + _pageSize > allOrders.length
          ? allOrders.length
          : startIndex + _pageSize;

      if (startIndex >= allOrders.length) {
        _hasMore = false;
      } else {
        final newOrders = allOrders.sublist(startIndex, endIndex);
        _orders.addAll(newOrders);
        _currentPage++;
      }
    } catch (e) {
      print('Error loading orders: $e');
    }

    _isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  // Filter orders by tags
  List<Order> getOrdersByTag(String query) {
    if (query.isEmpty) return _orders;

    return _orders
        .where((order) => order.tags
            .any((tag) => tag.toLowerCase().contains(query.toLowerCase())))
        .toList();
  }
}
