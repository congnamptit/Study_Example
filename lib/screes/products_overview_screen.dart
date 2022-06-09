import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_example/screes/cart_screen.dart';
import 'package:udemy_example/widgets/app_drawer.dart';

import '../widgets/product_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => const [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.all,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routerName);
                },
              ),
              value: cart.itemCount.toString(),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
