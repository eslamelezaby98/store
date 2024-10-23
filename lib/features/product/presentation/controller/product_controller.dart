import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:store/features/product/domain/repo/product_repo.dart';

import '../../data/model/product_model.dart';

class ProductController extends ChangeNotifier {
  final ProductRepo productRepo;

  ProductController({required this.productRepo});
  bool loading = false;
  String? errorMessage;
  List<ProductModel> products = [];
  List<ProductModel> searchedList = [];

  TextEditingController searchText = TextEditingController();

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

  searchProducts() {
    var productList = productRepo.searchProduct(products, searchText.text);
    searchedList = productList;
    notifyListeners();
  }
}
