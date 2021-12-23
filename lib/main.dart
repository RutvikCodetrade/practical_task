import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/presentation/pages/add_edit_product.dart';
import 'package:test_project/presentation/pages/home.dart';

import 'data/providers/item_product_provider.dart';
import 'data/providers/sort_index_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return ProductItemProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return SortIndexProvider();
          },
        ),
      ],
      child: MaterialApp(
        routes: {
          '/': (ctx) => const HomeProductsList(),
          'add_edit_list': (ctx) =>  AddEditProduct()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
