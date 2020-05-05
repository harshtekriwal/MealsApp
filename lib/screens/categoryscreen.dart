import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meals_app/widgets/categoryitem.dart';
import 'package:meals_app/dummy_data.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return GridView(
        padding: const EdgeInsets.all(15),
        children: DUMMY_CATEGORIES.map((catdata) {
          return CategoryItem(
            title: catdata.title,
            color: catdata.color,
            id: catdata.id,
          );
        }).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      );
    
  }
}
