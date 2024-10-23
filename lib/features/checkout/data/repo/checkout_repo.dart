import 'package:store/core/errors/expentions.dart';
import 'package:store/core/errors/failure.dart';
import 'package:store/features/checkout/data/model/order_model.dart';
import 'package:store/features/checkout/data/sources/local_order.dart';
import 'package:store/features/checkout/domain/order_repo.dart';

class CheckoutRepoImp extends CheckoutRepo {
  final LocalOrder localOrder;

  CheckoutRepoImp({required this.localOrder});
  @override
  Future addOrder(OrderModel orderModel) async {
    try {
      await localOrder.addOrder(orderModel);
    } on CacheExeption catch (e) {
      throw Failure(errMessage: e.errorMessage);
    }
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      List<OrderModel> orders = localOrder.getCacheOrder();
      return orders;
    } on CacheExeption catch (e) {
      throw Failure(errMessage: e.errorMessage);
    }
  }
}
