import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:store/core/connection/network_info.dart';
import 'package:store/core/databases/api/dio_consumer.dart';
import 'package:store/features/cart/data/repo/cart_repo.dart';
import 'package:store/features/cart/data/sources/local_cart.dart';
import 'package:store/features/cart/presentation/controller/cart_controller.dart';
import 'package:store/features/product/data/repo/product_repo.dart';
import 'package:store/features/product/data/sources/local_products.dart';
import 'package:store/features/product/data/sources/remote_product.dart';
import 'core/databases/cache/cache_helper.dart';
import 'features/product/presentation/controller/product_controller.dart';
import 'features/product/presentation/pages/product_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductController(
            productRepo: ProductRepoImp(
              networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
              remoteProducts:
                  RemoteProducts(apiConsumer: DioConsumer(dio: Dio())),
              localProducts: LocalProducts(cacheHelper: CacheHelper()),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => CartController(
            cartRepoImpl: CartRepoImpl(
              localCart: LocalCart(cacheHelper: CacheHelper()),
            ),
          ),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductScreen(),
      ),
    );
  }
}
