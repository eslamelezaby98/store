import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/core/widget/error/error_widget.dart';
import 'package:store/features/checkout/presentation/controller/order_controller.dart';
import 'package:store/features/checkout/presentation/view/widgets/order_cell.dart';

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
              return OrderCell(order: order);
            },
          );
        },
      ),
    );
  }
}
