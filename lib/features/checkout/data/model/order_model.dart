import '../../../cart/data/model/cart_model.dart';

class OrderModel {
  final int id;
  final List<CartModel> cartModels;
  final String status;
  final double total;

  OrderModel({
    required this.id,
    required this.cartModels,
    required this.status,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cartModels': cartModels.map((cart) => cart.toMap()).toList(),
      'status': status,
      'total': total,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      total: map["total"],
      cartModels: List<CartModel>.from(
        map['cartModels'].map((cartMap) => CartModel.fromMap(cartMap)),
      ),
      status: map['status'],
    );
  }
}
