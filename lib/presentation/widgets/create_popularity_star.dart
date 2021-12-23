import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateStarWithCounts extends StatelessWidget {
  double counts;

  CreateStarWithCounts({Key? key, required this.counts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) {
          return Icon(index < counts ? Icons.star : Icons.star_border_outlined);
        },
      ),
    );
  }
}
