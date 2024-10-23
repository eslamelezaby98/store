import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../cart/presentation/controller/cart_controller.dart';
import '../../data/model/product_model.dart';

class ProductCell extends StatelessWidget {
  const ProductCell({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
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
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
  }
}
