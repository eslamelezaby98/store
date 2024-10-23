import 'package:store/features/product/data/model/product_model.dart';

abstract class ProductRepo {
  Future<List<ProductModel>> getProducts();

  List<ProductModel> searchProduct(List<ProductModel> value, String text);
}
