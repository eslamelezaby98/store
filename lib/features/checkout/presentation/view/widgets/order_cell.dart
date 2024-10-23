import 'package:flutter/material.dart';
import 'package:store/features/checkout/data/model/order_model.dart';

class OrderCell extends StatelessWidget {
  final OrderModel order;
  const OrderCell({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Id : ${order.id}"),
            Text("Items : ${order.cartModels.length}"),
            Text("Total : ${order.total}"),
            Text("Status : ${order.status}"),
          ],
        ),
      ),
    );
  }
}
