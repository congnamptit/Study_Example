import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_example/providers/cart.dart';
import 'package:udemy_example/providers/order.dart';
import 'package:udemy_example/providers/product_provider.dart';
import 'package:udemy_example/screes/cart_screen.dart';
import 'package:udemy_example/screes/edit_product_screen.dart';
import 'package:udemy_example/screes/order_screen.dart';
import 'package:udemy_example/screes/product_detail_page.dart';
import 'package:udemy_example/screes/products_overview_screen.dart';
import 'package:udemy_example/screes/user_product_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.deepOrange),
        ),
        home: const ProductsOverviewScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          ProductsDetailPage.routerName: (context) =>
              const ProductsDetailPage(),
          CartScreen.routerName: (context) => const CartScreen(),
          OrderScreen.routerName: (context) => const OrderScreen(),
          UserProductScreen.routerName: (context) => const UserProductScreen(),
          EditProductScreen.routerName: (context) => const EditProductScreen(),
        },
      ),
    );
  }
}
