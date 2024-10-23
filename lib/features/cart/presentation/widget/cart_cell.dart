import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store/features/cart/data/model/cart_model.dart';
import '../controller/cart_controller.dart';

class CartCell extends StatelessWidget {
  const CartCell({
    super.key,
    required this.cart,
    required this.cartProvider,
  });

  final CartModel cart;
  final CartController cartProvider;

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
                imageUrl: cart.product.image,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Text(
              cart.product.title,
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${cart.product.price}\$",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                cartProvider.loading == cart.id
                    ? const CircularProgressIndicator()
                    : IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  "You will delete this product!",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      cartProvider.removeFromCart(
                                        cart.id,
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
