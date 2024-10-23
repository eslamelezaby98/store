import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/features/checkout/data/model/order_model.dart';
import 'package:store/features/checkout/presentation/controller/order_controller.dart';

import '../../../../core/widget/error/error_widget.dart';
import '../controller/cart_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartController>(context, listen: false).getCart();
    });
  }

  double calculateTotalPrice(CartController cartProvider) {
    return cartProvider.cartList.fold(
      0.0,
      (previousValue, cartItem) => previousValue + cartItem.product.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    var orderController = Provider.of<OrderController>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Consumer<CartController>(
        builder: (context, cartProvider, child) {
          if (cartProvider.loading == 0) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cartProvider.errorMessage != null) {
            return ErrorText(
              onTap: cartProvider.getCart,
              text: cartProvider.errorMessage!,
            );
          }

          if (cartProvider.cartList.isEmpty) {
            return const Center(child: Text('No Cart available'));
          }
          double totalPrice = calculateTotalPrice(cartProvider);

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: cartProvider.cartList.length,
                  itemBuilder: (context, index) {
                    final cart = cartProvider.cartList[index];

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
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
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
                                                      cartProvider
                                                          .removeFromCart(
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
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  orderController.addOrder(
                    OrderModel(
                      id: Random().nextInt(100),
                      cartModels: cartProvider.cartList,
                      status: "pending",
                      total: totalPrice,
                    ),
                    context,
                  );
                },
                child: Card(
                  elevation: 0,
                  color: Colors.green,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Checkout $totalPrice \$",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
