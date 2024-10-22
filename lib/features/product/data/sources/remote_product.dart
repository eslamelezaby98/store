import 'package:store/core/databases/api/api_consumer.dart';
import 'package:store/core/databases/api/end_points.dart';
import 'package:store/features/product/data/model/product_model.dart';

class RemoteProducts {
  final ApiConsumer apiConsumer;

  RemoteProducts({required this.apiConsumer});
  Future<List<ProductModel>> getProducts() async {
    var response = await apiConsumer.get(EndPoints.products);
    List<ProductModel> products = [];
    for (var element in response) {
      products.add(ProductModel.fromJson(element));
    }
    return products;
  }
}
