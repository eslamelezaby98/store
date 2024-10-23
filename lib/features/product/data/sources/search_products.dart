import '../model/product_model.dart';

class SearchProduct {
  List<ProductModel> getSearchedProducts(
    List<ProductModel> value,
    String text,
  ) {
    List<ProductModel> searchList = value.where((element) {
      return element.title.toLowerCase().contains(text) || element.description.contains(text);
    }).toList();
    return searchList;
  }
}
