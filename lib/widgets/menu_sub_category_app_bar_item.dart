import 'package:flutter/material.dart';

import 'menu_app_bar_item.dart';

class MenuSubCategoryAppBarItem extends StatelessWidget {
  final int? index;
  final String title;
  final String? selectedSubCategory;
  final Function? updateSubCategory;
  final Function? changeSelectedSubCategoryIndex;
  final Function? changeSelectedSubCategory;
  final Color? textColor;

  const MenuSubCategoryAppBarItem({
    Key? key,
    required this.title,
    this.selectedSubCategory,
    this.updateSubCategory,
    this.textColor,
    this.index,
    this.changeSelectedSubCategoryIndex,
    this.changeSelectedSubCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MenuAppBarItem(
      onTapDown: (details) {
        if (updateSubCategory != null) {
          updateSubCategory!(selectedSubCategory);
        }
        changeSelectedSubCategoryIndex!(index);
        changeSelectedSubCategory!(selectedSubCategory);
      },
      title: title,
      textColor: textColor,
    );
  }
}
