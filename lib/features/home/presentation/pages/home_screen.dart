import 'package:flutter/material.dart';
import 'package:store/features/cart/presentation/pages/cart_screen.dart';
import 'package:store/features/product/presentation/pages/product_screen.dart';
import '../../../checkout/presentation/pages/orders_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> screens = [
    const ProductScreen(),
    const CartScreen(),
    const OrdersScreen(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Cart',
            icon: Icon(Icons.shopping_bag),
          ),
          BottomNavigationBarItem(
            label: 'Orders',
            icon: Icon(Icons.category),
          ),
        ],
      ),
      body: screens.elementAt(index),
    );
  }
}
