// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:store/core/errors/expentions.dart';
import 'package:store/features/checkout/data/repo/checkout_repo.dart';
import 'package:store/features/checkout/presentation/pages/orders_screen.dart';
import '../../data/model/order_model.dart';

class OrderController extends ChangeNotifier {
  final CheckoutRepoImp checkoutRepoImp;
  OrderController({required this.checkoutRepoImp});

  String? errorMessage;
  bool loading = false;
  List<OrderModel> orders = [];
  Future addOrder(OrderModel orderModel, BuildContext context) async {
    try {
      await checkoutRepoImp.addOrder(orderModel);
      notifyListeners();
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const OrdersScreen()),
      );
    } on CacheExeption catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future getOrders() async {
    try {
      loading = true;
      notifyListeners();
      var orderList = await checkoutRepoImp.getOrders();
      orders = orderList;
      loading = false;
      notifyListeners();
    } on CacheExeption catch (e) {
      errorMessage = e.toString();
      loading = false;
      notifyListeners();
    }
  }
}
