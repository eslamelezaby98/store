import 'package:store/core/connection/network_info.dart';
import 'package:store/core/errors/expentions.dart';
import 'package:store/core/errors/failure.dart';
import 'package:store/features/product/data/model/product_model.dart';
import 'package:store/features/product/data/sources/local_products.dart';
import 'package:store/features/product/data/sources/remote_product.dart';
import 'package:store/features/product/domain/repo/product_repo.dart';

class ProductRepoImp extends ProductRepo {
  final NetworkInfo networkInfo;
  final RemoteProducts remoteProducts;
  final LocalProducts localProducts;

  ProductRepoImp({
    required this.networkInfo,
    required this.remoteProducts,
    required this.localProducts,
  });

  @override
  Future<List<ProductModel>> getProducts() async {
    if (await networkInfo.isConnected!) {
      try {
        var productsList = await remoteProducts.getProducts();
        localProducts.cacheProducts(productsList);
        return productsList;
      } on ServerException catch (e) {
        throw Failure(errMessage: e.errorModel.errorMessage);
      }
    } else {
      try {
        var products = localProducts.getCachedProducts();
        return products;
      } on CacheExeption catch (e) {
        throw Failure(errMessage: e.errorMessage);
      }
    }
  }
}
