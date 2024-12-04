import 'package:cached_network_image/cached_network_image.dart';
import 'package:finkart/features/orders/components/custom_container.dart';
import 'package:finkart/features/orders/components/order_tile.dart';
import 'package:finkart/features/orders/components/search_text_field.dart';
import 'package:finkart/features/orders/models/order_model.dart';
import 'package:finkart/features/orders/view_models/order_details_view_model.dart';
import 'package:finkart/features/orders/view_models/orders_view_model.dart';
import 'package:finkart/features/orders/views/order_details_screen.dart';
import 'package:finkart/features/shared/colors/colors.dart';
import 'package:finkart/features/shared/components/custom_text.dart';
import 'package:finkart/features/shared/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<OrdersViewModel>().loadOrders();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: screenBackgroundColor,
        // title: const Text("Paginated Orders"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchTextField(
              hintText: "Search by Tags...",
              controller: _searchController,
              onChanged: (query) {
                setState(() {
                  _searchQuery = query.trim();
                });
              },
              enabled: true,
            ),
          ),
        ),
      ),
      body: Consumer<OrdersViewModel>(
        builder: (context, viewModel, child) {
          final filteredOrders = viewModel.getOrdersByTag(_searchQuery);

          if (viewModel.orders.isEmpty && viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (filteredOrders.isEmpty) {
            return const Center(child: CustomText(text: "No orders found."));
          }

          return ListView.builder(
            itemCount: filteredOrders.length + 1,
            itemBuilder: (context, index) {
              if (index < filteredOrders.length) {
                final order = filteredOrders[index];
                return OrderTile(order: order);
              }

              if (viewModel.hasMore && _searchQuery.isEmpty) {
                viewModel.loadOrders(); // Load more data when search is empty
                return const Center(child: CircularProgressIndicator());
              }

              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CustomText(text: "No more orders.")),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
