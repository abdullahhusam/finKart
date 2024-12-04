import 'package:cached_network_image/cached_network_image.dart';
import 'package:finkart/features/orders/components/custom_container.dart';
import 'package:finkart/features/orders/models/order_model.dart';
import 'package:finkart/features/orders/view_models/order_details_view_model.dart';
import 'package:finkart/features/orders/views/order_details_screen.dart';
import 'package:finkart/features/shared/colors/colors.dart';
import 'package:finkart/features/shared/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderTile extends StatelessWidget {
  final Order order;

  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<OrderDetailsViewModel>(context, listen: false)
            .setSelectedOrder(order);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(),
          ),
        );
      },
      child: CustomContainer(
        marginAll: 16,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        size: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: order.status,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: primaryColor,
                          ),
                          CustomText(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            text: order.registered.toString().substring(0, 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        size: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Buyer",
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: darkGreyColor,
                          ),
                          CustomText(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              text: order.buyer),
                        ],
                      ),
                    ],
                  ),
                  CustomText(
                    text: order.price,
                  )
                ],
              ),
              // Text(order.buyer),
              // Text(order.company),
              // Text(order.price)
            ],
          ),
        ),
      ),
    );
  }
}
