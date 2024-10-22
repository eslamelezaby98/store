import 'package:store/features/cart/data/model/cart_model.dart';
import 'package:store/features/product/data/model/product_model.dart';

abstract class CartRepo {
  Future<List<CartModel>> getCart();

  Future addToCart(ProductModel product);

  Future removeFromCart(int id);
}
