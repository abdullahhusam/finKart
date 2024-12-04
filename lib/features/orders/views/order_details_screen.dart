import 'package:cached_network_image/cached_network_image.dart';
import 'package:finkart/features/orders/view_models/order_details_view_model.dart';
import 'package:finkart/features/shared/components/custom_icon_button.dart';
import 'package:finkart/features/shared/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedOrder = context.watch<OrderDetailsViewModel>().selectedOrder;

    if (selectedOrder == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Order Details')),
        body: const Center(
          child: Text('No order selected.'),
        ),
      );
    }
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 35, 24, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomIconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        size: 20,
                        icon: Icons.arrow_back_ios_new_rounded,
                      ),
                      const CustomText(
                        // marginTop: 10,
                        text: "Order Details",
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                                imageUrl: selectedOrder.picture,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          CustomText(
                            marginTop: 16,
                            marginBottom: 8,
                            text: "ID: ${selectedOrder.id}",
                          ),
                          CustomText(
                            text: "Buyer: ${selectedOrder.buyer}",
                            marginBottom: 8,
                          ),
                          CustomText(
                            text: "Company: ${selectedOrder.company}",
                            marginBottom: 8,
                          ),
                          CustomText(
                            text: "Price: ${selectedOrder.price}",
                            marginBottom: 8,
                          ),
                          CustomText(
                            text: "Status: ${selectedOrder.status}",
                            marginBottom: 8,
                          ),
                          CustomText(
                            text:
                                "Registered: ${selectedOrder.registered.toString().substring(0, 10)}",
                            marginBottom: 8,
                          ),
                          const CustomText(
                            text: "Tags:",
                            marginBottom: 8,
                          ),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: selectedOrder.tags.map((tag) {
                              return Chip(
                                label: Text(tag),
                                backgroundColor: Colors.blue.shade100,
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
