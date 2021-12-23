import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_project/data/providers/item_product_provider.dart';
import 'package:test_project/models/is_for_edit_model.dart';
import 'package:test_project/models/product_item_model.dart';

import 'create_popularity_star.dart';

class CardProductItem extends StatelessWidget {
  String name;
  double popCount;
  String launchSite;
  String launchAt;
  int pos;
  ProductItemModel productData;

  CardProductItem(
      {Key? key,
      required this.name,
      required this.launchAt,
      required this.launchSite,
      required this.popCount,
      required this.pos,
      required this.productData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
      child: Row(
        children: [
          Expanded(child: buildDataColumn()),
          buldEditDeleteColumn(context)
        ],
      ),
    );
  }

  Widget buildDataColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              name,
              style:
                  GoogleFonts.poppins(color: Colors.blueAccent, fontSize: 18),
              overflow: TextOverflow.ellipsis,
            )),
        Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              launchSite,
              overflow: TextOverflow.ellipsis,
            )),
        Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              launchAt,
              overflow: TextOverflow.ellipsis,
            )),
        Padding(
            padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
            child: CreateStarWithCounts(
              counts: popCount,
            ))
      ],
    );
  }

  Widget buldEditDeleteColumn(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'add_edit_list',
                  arguments: IsForEdit(true, productData, pos));
            },
            icon: const Icon(Icons.edit)),
        IconButton(
            onPressed: () {
              showDeleteAlert(context);
            },
            icon: const Icon(Icons.delete_forever))
      ],
    );
  }

  void showDeleteAlert(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text('Do you really want to delete!'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<ProductItemProvider>().removeProduct(pos);
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }
}
