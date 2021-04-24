import 'package:flutter/material.dart';
import 'provider/menu_inline_filter_provider.dart';

class MenuAppBarItem extends StatelessWidget {
  final String title;
  final Color? textColor;
  final void Function(TapDownDetails)? onTapDown;

  const MenuAppBarItem({
    Key? key,
    required this.title,
    this.textColor = Colors.grey,
    this.onTapDown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _menuInlineFilterProvider = MenuInlineFilterProvider.of(context)!;

    return GestureDetector(
      onTapDown: onTapDown,
      child: Container(
        height: _menuInlineFilterProvider.height,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Center(
          child: Text(
            title.toUpperCase(),
            overflow: TextOverflow.fade,
            style: TextStyle(
                color: textColor,
                fontSize: _menuInlineFilterProvider.fontSize,
                fontFamily: _menuInlineFilterProvider.fontFamily),
          ),
        ),
      ),
    );
  }
}
