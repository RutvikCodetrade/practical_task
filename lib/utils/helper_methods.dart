import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:test_project/data/providers/item_product_provider.dart';

void sortProducts(BuildContext context, int typeOfSorting) {
  switch (typeOfSorting) {
    case 0:
      context.read<ProductItemProvider>().sortByProductName();
      break;
    case 1:
      context.read<ProductItemProvider>().sortByProductLaunchSite();
      break;
    case 2:
      context.read<ProductItemProvider>().sortByDate();
      break;
    case 3:
      context.read<ProductItemProvider>().sortByPopularity();
      break;
    default:
      context.read<ProductItemProvider>().sortByProductName();
  }
}

String formatDate(DateTime pickedDate) {
  return '${pickedDate.day} / ${pickedDate.month} / ${pickedDate.year}';
}
