import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:test_project/data/providers/item_product_provider.dart';
import 'package:test_project/data/providers/sort_index_provider.dart';
import 'package:test_project/models/is_for_edit_model.dart';
import 'package:provider/provider.dart';
import 'package:test_project/models/product_item_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_project/utils/helper_methods.dart';

class AddEditProduct extends StatefulWidget {
  const AddEditProduct({Key? key}) : super(key: key);

  @override
  State<AddEditProduct> createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {
  String? selDate;
  String productName = "", productSite = "";
  double selPopCount = 0.0;

  TextEditingController productNameController = TextEditingController();
  TextEditingController productLaunchSiteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    selDate = formatDate(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    IsForEdit? data = ModalRoute.of(context)?.settings.arguments as IsForEdit?;

    // if data comes null at that time user directly navigate using typing url
    if (data == null) {
      Navigator.pop(context);
    }

    ProductItemModel? pData = data?.productData;

    if (pData != null) {
      selDate = pData.launchDate;
      selPopCount = pData.popCount;
      productName = pData.productName;
      productSite = pData.launchSite;

      productNameController.text = productName;
      productLaunchSiteController.text = productSite;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(data!.isFroEdit ? 'Edit Product' : 'Add Product'),
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: productNameController,
                decoration: InputDecoration(
                    hintText: productName.isEmpty ? 'Enter Product Name' : null,
                    border: const OutlineInputBorder()),
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: productLaunchSiteController,
                decoration: InputDecoration(
                    hintText: productSite.isEmpty ? 'Enter Launch Site' : null,
                    border: const OutlineInputBorder()),
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Text('Launch At : $selDate')),
                    ),
                    IconButton(
                        onPressed: () {
                          selectDate(context);
                        },
                        icon: const Icon(Icons.date_range))
                  ],
                ),
              )),
          RatingBar.builder(
              initialRating: selPopCount,
              itemBuilder: (context, pos) {
                return const Icon(
                  Icons.star_rate_rounded,
                  color: Colors.blueAccent,
                );
              },
              onRatingUpdate: (ratings) {
                selPopCount = ratings;
              }),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // print("pName : ${productNameController.text}, lSite : ${productLaunchSiteController.text}, lDate : ${selDate}, popCount : ${selPopCount}");

                  if (productNameController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Please Fill Product Name!",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);

                    return;
                  }

                  if (productLaunchSiteController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Please Fill Product Launch Site!",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);

                    return;
                  }

                  if (selPopCount == 0) {
                    Fluttertoast.showToast(
                        msg: "Please Rate Product Popularity!",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);

                    return;
                  }

                  bool isProductAlreadyExists = context
                      .read<ProductItemProvider>()
                      .isProductAvailable(
                          productNameController.text, data.position);

                  if (isProductAlreadyExists) {
                    Fluttertoast.showToast(
                        msg: "Product Already Exists!",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    if (data.isFroEdit) {
                      ProductItemModel addNewData = ProductItemModel(
                          productNameController.text,
                          productLaunchSiteController.text,
                          selDate.toString(),
                          selPopCount);
                      context
                          .read<ProductItemProvider>()
                          .updateAt(data.position, addNewData);
                    } else {
                      ProductItemModel addNewData = ProductItemModel(
                          productNameController.text,
                          productLaunchSiteController.text,
                          selDate.toString(),
                          selPopCount);
                      context
                          .read<ProductItemProvider>()
                          .addNewProduct(addNewData);
                    }

                    // sort products user product updated or newly added
                    sortProducts(context,context.read<SortIndexProvider>().selPos);
                    Navigator.pop(context);
                  }
                },
                child:
                    Text(data.isFroEdit ? 'Update Product' : 'Add New Product'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2222));

    if (pickedDate != null) {
      setState(() {
        selDate = formatDate(pickedDate);
      });
    }
  }

}
