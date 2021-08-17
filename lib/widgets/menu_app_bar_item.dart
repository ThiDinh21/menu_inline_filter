import 'package:flutter/material.dart';

import '../provider/menu_inline_filter_provider.dart';

class MenuAppBarItem extends StatelessWidget {
  final String title;
  final Color? textColor;
  final void Function()? onTap;

  const MenuAppBarItem({
    Key? key,
    required this.title,
    this.textColor = Colors.grey,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _menuInlineFilterProvider = MenuInlineFilterProvider.of(context)!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: _menuInlineFilterProvider.height,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Center(
          child: Text(
            title.toUpperCase(),
            overflow: TextOverflow.fade,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontFamily: 'Avenir',
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
