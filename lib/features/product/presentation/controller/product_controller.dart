import 'package:flutter/material.dart';
import 'package:store/features/product/domain/repo/product_repo.dart';

import '../../data/model/product_model.dart';

class ProductController extends ChangeNotifier {
  final ProductRepo productRepo;

  ProductController({required this.productRepo});
  bool loading = false;
  String? errorMessage;
  List<ProductModel> products = [];

  Future getProduct() async {
    loading = true;
    errorMessage = null;
    notifyListeners();
    try {
      var productList = await productRepo.getProducts();
      products = productList;
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
