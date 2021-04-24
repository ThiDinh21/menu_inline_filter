import 'package:flutter/material.dart';

import 'menu_app_bar_item.dart';
import 'vertical_divider.dart' as vd;

class CurrentSelectedMenuItem extends StatelessWidget {
  final List<String> categories;
  final Color selectedCategoryColor;
  final int selectedCategoryIndex;
  final Color backgroundColor;
  final bool isCurrentItemShown;
  final void Function(TapDownDetails) onTapFunction;

  const CurrentSelectedMenuItem({
    Key? key,
    required this.categories,
    required this.selectedCategoryIndex,
    required this.backgroundColor,
    required this.selectedCategoryColor,
    required this.isCurrentItemShown,
    required this.onTapFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      child: isCurrentItemShown
          ? Container(
              color: backgroundColor,
              child: Row(
                children: [
                  MenuAppBarItem(
                    onTapDown: onTapFunction,
                    title: categories[selectedCategoryIndex],
                    textColor: selectedCategoryColor,
                  ),
                  const vd.VerticalDivider(),
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
