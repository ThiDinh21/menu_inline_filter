import 'package:flutter/material.dart';

import 'menu_app_bar_item.dart';

class MenuCategoryAppBarItem extends StatefulWidget {
  final String title;
  final int index;
  final String? menuItemCategory;
  final Function? updateCategory;
  final Function? changeSelectedCategoryIndex;
  final Function? resetHorizontalOffset;
  final Function? getItemSize;
  final Function? changeMenuFilterOffset;
  final Color? textColor;
  final String? selectedCategory;

  const MenuCategoryAppBarItem({
    Key? key,
    required this.title,
    this.menuItemCategory,
    this.updateCategory,
    this.textColor,
    this.changeMenuFilterOffset,
    this.resetHorizontalOffset,
    this.selectedCategory,
    this.getItemSize,
    required this.index,
    this.changeSelectedCategoryIndex,
  }) : super(key: key);

  @override
  _MenuCategoryAppBarItemState createState() => _MenuCategoryAppBarItemState();
}

class _MenuCategoryAppBarItemState extends State<MenuCategoryAppBarItem> {
  // detect if menu item state is open or close
  late bool _isOpen;

  @override
  void initState() {
    _isOpen = false;
    super.initState();
  }

  void _moveMenuFilter(BuildContext context) {
    // closes category bar when selecting current category
    if (widget.selectedCategory == widget.menuItemCategory && !_isOpen) {
      widget.resetHorizontalOffset!();
    } else {
      widget.changeMenuFilterOffset!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MenuAppBarItem(
      onTap: () {
        setState(() {
          _isOpen = !_isOpen;
        });
        //update category for filtering menut list
        if (widget.updateCategory != null) {
          widget.updateCategory!(widget.menuItemCategory);
        }
        //change selected category index
        widget.changeSelectedCategoryIndex!(widget.index);
        //move menu filter based on menu item selection
        _moveMenuFilter(context);
        //get size of individual menu item (used for closed transition animation)
        widget.getItemSize!(widget.menuItemCategory);
      },
      title: widget.title,
      textColor: widget.textColor,
    );
  }
}
