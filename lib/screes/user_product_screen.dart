import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_example/providers/product_provider.dart';
import 'package:udemy_example/screes/edit_product_screen.dart';
import 'package:udemy_example/widgets/app_drawer.dart';

import '../widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);

  static const routerName = 'user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false)
        .fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Product'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routerName);
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (ctx, index) {
              return Column(
                children: [
                  UserProductItem(
                    title: productsData.items[index].title!,
                    imgUrl: productsData.items[index].imageUrl!,
                    id: productsData.items[index].id!.toString(),
                  ),
                  const Divider(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
