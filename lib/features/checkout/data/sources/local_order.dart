import 'dart:convert';
import 'package:store/core/databases/cache/cache_helper.dart';
import 'package:store/core/errors/failure.dart';
import 'package:store/features/checkout/data/model/order_model.dart';
import '../../../../core/errors/expentions.dart';

class LocalOrder {
  final CacheHelper cacheHelper;
  LocalOrder({required this.cacheHelper});

  var key = "orderCache";
  var cart = "cartCache";

  Future cacheOrders(List<OrderModel>? orders) async {
    if (orders != null) {
      final List<String> cachedOrders =
          orders.map((p) => json.encode(p.toMap())).toList();
      await cacheHelper.saveList(key: key, value: cachedOrders);
    } else {
      throw CacheExeption(errorMessage: "No Internet Connection");
    }
  }

  List<OrderModel> getCacheOrder() {
    try {
      final jsonString = cacheHelper.getList(key) ?? [];
      return jsonString.map((p) => OrderModel.fromMap(json.decode(p))).toList();
    } on CacheExeption catch (e) {
      throw Failure(errMessage: e.errorMessage);
    }
  }

  Future addOrder(OrderModel orderModel) async {
    try {
      var orderList = getCacheOrder();
      orderList.add(orderModel);
      await cacheOrders(orderList);
      await cacheHelper.removeData(key: cart);
    } on CacheExeption catch (e) {
      throw Failure(errMessage: e.errorMessage);
    }
  }
}
