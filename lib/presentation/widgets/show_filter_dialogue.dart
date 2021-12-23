import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/data/providers/item_product_provider.dart';
import 'package:test_project/data/providers/sort_index_provider.dart';

class ShowSortDialogue extends StatefulWidget {
  const ShowSortDialogue({Key? key}) : super(key: key);

  @override
  _ShowSortDialogueState createState() => _ShowSortDialogueState();
}

class _ShowSortDialogueState extends State<ShowSortDialogue> {
  int selIndex = 0;

  @override
  Widget build(BuildContext context) {
    selIndex = context.watch<SortIndexProvider>().selPos;

    return Dialog(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<int>(
                title: const Text('Sort By Product Name'),
                value: 0,
                groupValue: selIndex,
                onChanged: (value) {
                  setState(() {
                    selIndex = value!;
                    context.read<SortIndexProvider>().setSelPos(selIndex);
                    context.read<ProductItemProvider>().sortByProductName();
                    Navigator.pop(context);
                  });
                }),
            RadioListTile<int>(
                title: const Text('Sort By Product Launch Site'),
                value: 1,
                groupValue: selIndex,
                onChanged: (value) {
                  setState(() {
                    selIndex = value!;
                    context.read<SortIndexProvider>().setSelPos(selIndex);
                    context
                        .read<ProductItemProvider>()
                        .sortByProductLaunchSite();
                    Navigator.pop(context);
                  });
                }),
            RadioListTile<int>(
                title: const Text('Sort By Product Date'),
                value: 2,
                groupValue: selIndex,
                onChanged: (value) {
                  setState(() {
                    selIndex = value!;
                    context.read<SortIndexProvider>().setSelPos(selIndex);
                    context.read<ProductItemProvider>().sortByDate();
                    Navigator.pop(context);
                  });
                }),
            RadioListTile<int>(
                title: const Text('Sort By Product Rating'),
                value: 3,
                groupValue: selIndex,
                onChanged: (value) {
                  setState(() {
                    selIndex = value!;
                    context.read<SortIndexProvider>().setSelPos(selIndex);
                    context.read<ProductItemProvider>().sortByPopularity();
                    Navigator.pop(context);
                  });
                }),
          ],
        ),
      ),
    );
  }
}
