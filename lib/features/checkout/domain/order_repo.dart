import '../data/model/order_model.dart';

abstract class CheckoutRepo {
  Future addOrder(OrderModel orderModel);

  Future<List<OrderModel>> getOrders();
}
