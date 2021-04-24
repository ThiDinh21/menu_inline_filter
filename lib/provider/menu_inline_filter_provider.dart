import 'package:flutter/material.dart';

class MenuInlineFilterProvider extends InheritedWidget {
  final double height;
  final double fontSize;
  final String fontFamily;

  const MenuInlineFilterProvider({
    Key? key,
    required this.height,
    required this.fontSize,
    required this.fontFamily,
    required Widget child,
  }) : super(key: key, child: child);

  static MenuInlineFilterProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MenuInlineFilterProvider>();
  }

  @override
  bool updateShouldNotify(MenuInlineFilterProvider old) {
    return true;
  }
}
