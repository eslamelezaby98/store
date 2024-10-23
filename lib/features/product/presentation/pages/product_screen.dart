import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/features/cart/presentation/controller/cart_controller.dart';
import 'package:store/features/cart/presentation/pages/cart_screen.dart';
import '../../../../core/widget/error/error_widget.dart';
import '../controller/product_controller.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductController>(context, listen: false).getProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ));
            },
            icon: const Icon(Icons.shopping_basket_outlined),
          ),
        ],
      ),
      body: Consumer<ProductController>(
        builder: (context, productProvider, child) {
          if (productProvider.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (productProvider.errorMessage != null) {
            return ErrorText(
              onTap: productProvider.getProduct,
              text: productProvider.errorMessage!,
            );
          }

          if (productProvider.products.isEmpty) {
            return const Center(child: Text('No products available'));
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: productProvider.products.length,
            itemBuilder: (context, index) {
              final product = productProvider.products[index];
              return Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      Center(
                        child: CachedNetworkImage(
                          height: 80,
                          width: 100,
                          imageUrl: product.image,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Text(
                        product.title,
                        maxLines: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${product.price}\$",
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Consumer<CartController>(
                            builder: (context, value, child) {
                              return value.loading == product.id
                                  ? const CircularProgressIndicator()
                                  : IconButton(
                                      onPressed: () {
                                        value.addToCart(product);
                                      },
                                      icon: const Icon(
                                        Icons.shopping_cart,
                                        color: Colors.black,
                                      ),
                                    );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
