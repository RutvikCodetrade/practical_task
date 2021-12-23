import 'package:flutter/material.dart';
import 'package:test_project/models/product_item_model.dart';

class ProductItemProvider with ChangeNotifier {
  List<ProductItemModel> _pList = [];

  List<ProductItemModel> get productsList {
    return _pList;
  }

  void addNewProduct(ProductItemModel p) {
    productsList.add(p);
    notifyListeners();
  }

  void removeProduct(int pos) {
    productsList.removeAt(pos);
    notifyListeners();
  }

  void updateAt(int pos, ProductItemModel u) {
    productsList[pos] = u;
    notifyListeners();
  }

  bool isProductAvailable(String pName,
      int currentIndex /* for when user go for edit skip current index */) {
    if (productsList.isNotEmpty) {
      for (int i = 0; i < productsList.length; i++) {
        if (i == currentIndex) {
          continue;
        }
        if (productsList.elementAt(i).productName.compareTo(pName) == 0) {
          return true;
        }
      }
    }
    return false;
  }

  void sortByProductName() {
    productsList.sort((a, b) => a.productName.compareTo(b.productName));
    notifyListeners();
  }

  void sortByProductLaunchSite() {
    productsList.sort((a, b) => a.launchSite.compareTo(b.launchSite));
    notifyListeners();
  }

  void sortByDate() {
    productsList.sort((a, b) =>
        DateTime.parse(a.launchDate).compareTo(DateTime.parse(b.launchDate)));
    notifyListeners();
  }

  void sortByPopularity() {
    productsList.sort((a, b) => a.popCount.compareTo(b.popCount));
    notifyListeners();
  }
}
