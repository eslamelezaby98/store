import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/features/checkout/data/model/order_model.dart';
import 'package:store/features/checkout/presentation/controller/order_controller.dart';
import '../../../../core/widget/error/error_widget.dart';
import '../controller/cart_controller.dart';
import '../widget/cart_cell.dart';

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

                    return CartCell(cart: cart, cartProvider: cartProvider);
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
