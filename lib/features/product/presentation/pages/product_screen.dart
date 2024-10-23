import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/features/cart/presentation/pages/cart_screen.dart';
import '../../../../core/widget/error/error_widget.dart';
import '../controller/product_controller.dart';
import '../widget/product_cell.dart';

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
          var isSearch = productProvider.searchText.text.isNotEmpty;
          var data = isSearch
              ? productProvider.searchedList
              : productProvider.products;
          if (productProvider.products.isEmpty) {
            return const Center(child: Text('No products available'));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: productProvider.searchText,
                  onChanged: (value) {
                    productProvider.searchProducts();
                  },
                  decoration: const InputDecoration(
                    hintText: "Search",
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder()
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final product = data[index];
                    return ProductCell(product: product);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
