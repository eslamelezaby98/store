import 'dart:convert';
import 'dart:math';

import 'package:store/core/databases/cache/cache_helper.dart';
import 'package:store/features/cart/data/model/cart_model.dart';
import 'package:store/features/product/data/model/product_model.dart';
import '../../../../core/errors/expentions.dart';

class LocalCart {
  final CacheHelper cacheHelper;
  LocalCart({required this.cacheHelper});

  var key = "cartCache";

  Future cacheCart(List<CartModel>? cartCache) async {
    if (cartCache != null) {
      final List<String> cachedCarts =
          cartCache.map((p) => json.encode(p.toMap())).toList();
      await cacheHelper.saveList(key: key, value: cachedCarts);
    } else {
      throw CacheExeption(errorMessage: "No Internet Connection");
    }
  }

  List<CartModel> getCachedCart() {
    final jsonString = cacheHelper.getList(key) ?? [];
    return jsonString.map((p) => CartModel.fromMap(json.decode(p))).toList();
  }

  Future addToCart(ProductModel productModel) async {
    try {
      var cartList = getCachedCart();
      cartList.add(
        CartModel(id: Random().nextInt(100), product: productModel, count: 1),
      );
      await cacheCart(cartList);
    } catch (e) {
      throw CacheExeption(errorMessage: "No Internet Connection");
    }
  }

  Future removeFromCart(int id) async {
    try {
      var cartList = getCachedCart();
      cartList.removeWhere((element) => element.id == id);
      await cacheCart(cartList);
    } catch (e) {
      throw CacheExeption(errorMessage: "No Internet Connection");
    }
  }
}
