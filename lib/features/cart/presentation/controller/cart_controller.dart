import 'package:flutter/foundation.dart';
import 'package:store/features/cart/data/model/cart_model.dart';
import 'package:store/features/cart/data/repo/cart_repo.dart';

import '../../../product/data/model/product_model.dart';

class CartController extends ChangeNotifier {
  final CartRepoImpl cartRepoImpl;

  CartController({required this.cartRepoImpl});

  List<CartModel> cartList = [];
  int? loading;
  String? errorMessage;
  Future getCart() async {
    loading = 0;
    errorMessage = null;
    notifyListeners();
    try {
      List<CartModel> carts = await cartRepoImpl.getCart();
      cartList = carts;
      loading = null;
      notifyListeners();
    } catch (e) {
      loading = null;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future addToCart(ProductModel product) async {
    try {
      loading = product.id;
      notifyListeners();
      await cartRepoImpl.addToCart(product);
      loading = null;
      notifyListeners();
    } catch (e) {
      loading = null;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future removeFromCart(int id) async {
    try {
      loading = id;
      notifyListeners();
      await cartRepoImpl.removeFromCart(id);
      cartList.removeWhere((element) => element.id == id);
      loading = null;
      notifyListeners();
    } catch (e) {
      loading = null;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
