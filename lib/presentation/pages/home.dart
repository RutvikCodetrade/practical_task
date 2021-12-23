import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:test_project/data/providers/item_product_provider.dart';
import 'package:test_project/models/is_for_edit_model.dart';
import 'package:test_project/presentation/widgets/item_product.dart';
import 'package:test_project/presentation/widgets/show_filter_dialogue.dart';

class HomeProductsList extends StatefulWidget {
  const HomeProductsList({Key? key}) : super(key: key);

  @override
  State<HomeProductsList> createState() => _HomeProductsListState();
}

class _HomeProductsListState extends State<HomeProductsList> {
  int tempSortIndex = 0;
  bool toggleGridList = true; // default list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products List'),
        actions: (kIsWeb)
            ? <Widget>[
                IconButton(
                    onPressed: () {
                      setState(() {
                        toggleGridList = !toggleGridList;
                      });
                    },
                    icon: const Icon(Icons.format_list_bulleted_rounded)),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const ShowSortDialogue();
                          });
                    },
                    icon: const Icon(Icons.filter_list)),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "add_edit_list",
                          arguments: IsForEdit(false, null, -1));
                    },
                    icon: const Icon(Icons.add)),
              ]
            : <Widget>[
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const ShowSortDialogue();
                          });
                    },
                    icon: const Icon(Icons.filter_list)),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "add_edit_list",
                          arguments: IsForEdit(false, null, -1));
                    },
                    icon: const Icon(Icons.add)),
              ],
      ),
      body: toggleGridList
          ? ListView.builder(
              itemCount:
                  context.watch<ProductItemProvider>().productsList.length,
              itemBuilder: (ctx, pos) {
                return CardProductItem(
                  launchSite: ctx
                      .watch<ProductItemProvider>()
                      .productsList
                      .elementAt(pos)
                      .launchSite,
                  launchAt: ctx
                      .watch<ProductItemProvider>()
                      .productsList
                      .elementAt(pos)
                      .launchDate,
                  name: ctx
                      .watch<ProductItemProvider>()
                      .productsList
                      .elementAt(pos)
                      .productName,
                  popCount: ctx
                      .watch<ProductItemProvider>()
                      .productsList
                      .elementAt(pos)
                      .popCount,
                  pos: pos,
                  productData: context
                      .watch<ProductItemProvider>()
                      .productsList
                      .elementAt(pos),
                );
              })
          : GridView.count(
              crossAxisCount: 4,
              children: List.generate(
                  context.watch<ProductItemProvider>().productsList.length,
                  (index) => CardProductItem(
                        launchSite: context
                            .watch<ProductItemProvider>()
                            .productsList
                            .elementAt(index)
                            .launchSite,
                        launchAt: context
                            .watch<ProductItemProvider>()
                            .productsList
                            .elementAt(index)
                            .launchDate,
                        name: context
                            .watch<ProductItemProvider>()
                            .productsList
                            .elementAt(index)
                            .productName,
                        popCount: context
                            .watch<ProductItemProvider>()
                            .productsList
                            .elementAt(index)
                            .popCount,
                        pos: index,
                        productData: context
                            .watch<ProductItemProvider>()
                            .productsList
                            .elementAt(index),
                      )),
            ),
    );
  }
}
