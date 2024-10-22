import 'package:store/core/errors/expentions.dart';
import 'package:store/core/errors/failure.dart';
import 'package:store/features/cart/data/model/cart_model.dart';
import 'package:store/features/cart/data/sources/local_cart.dart';
import 'package:store/features/cart/domain/repo/cart_repo.dart';
import 'package:store/features/product/data/model/product_model.dart';

class CartRepoImpl extends CartRepo {
  final LocalCart localCart;
  CartRepoImpl({required this.localCart});

  @override
  Future addToCart(ProductModel product) async {
    try {
      await localCart.addToCart(product);
    } on CacheExeption catch (e) {
      throw Failure(errMessage: e.errorMessage);
    }
  }

  @override
  Future<List<CartModel>> getCart() async {
    try {
      var cacheCart = localCart.getCachedCart();
      return cacheCart;
    } on CacheExeption catch (e) {
      throw Failure(errMessage: e.errorMessage);
    }
  }

  @override
  Future removeFromCart(int id) async {
    try {
      await localCart.removeFromCart(id);
    } on CacheExeption catch (e) {
      throw Failure(errMessage: e.errorMessage);
    }
  }
}
