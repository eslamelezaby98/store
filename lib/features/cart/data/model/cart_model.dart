import '../../../product/data/model/product_model.dart';

class CartModel {
  final int id;
  final ProductModel product;
  final int count;

  CartModel({
    required this.id,
    required this.product,
    required this.count,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product.toJson(),
      'count': count,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'],
      product: ProductModel.fromJson(map['product']),
      count: map['count'],
    );
  }
}
