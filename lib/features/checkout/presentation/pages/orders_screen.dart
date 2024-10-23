import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/core/widget/error/error_widget.dart';
import 'package:store/features/checkout/presentation/controller/order_controller.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderController>(context, listen: false).getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: Consumer<OrderController>(
        builder: (context, orderProvider, child) {
          if (orderProvider.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (orderProvider.errorMessage != null) {
            return ErrorText(
              onTap: orderProvider.getOrders,
              text: orderProvider.errorMessage!,
            );
          }

          if (orderProvider.orders.isEmpty) {
            return const Center(child: Text('No Orders available'));
          }

          return ListView.builder(
            itemCount: orderProvider.orders.length,
            itemBuilder: (context, index) {
              final order = orderProvider.orders[index];
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
            },
          );
        },
      ),
    );
  }
}
