library menu_inline_filter;

import 'package:flutter/material.dart';

import 'provider/menu_inline_filter_provider.dart';
import 'widgets/menu_app_bar_item.dart';
import 'widgets/menu_category_app_bar_item.dart';
import 'widgets/menu_sub_category_app_bar_item.dart';
import 'widgets/vertical_divider.dart' as vd;

class MenuInlineFilter extends StatefulWidget {
  // callback used when category selected
  final Function? updateCategory;
  // callback used when category subcategory selected
  final Function? updateSubCategory;
  // list of categories
  final List<String> categories;
  // list of list of subcategories
  final List<List<String>> subCategories;
  // height of menu filter
  final double height;
  // horizontal padding of menu filter
  final double horizontalPadding;
  // background color of menu filter
  final Color backgroundColor;
  final Color selectedCategoryColor;
  final Color textColor;
  final Color selectedSubCategoryColor;
  final Color unselectedCategoryColor;
  final Color unselectedSubCategoryColor;
  final double fontSize;
  final String fontFamily;
  final int animationDuration;

  const MenuInlineFilter({
    Key? key,
    this.updateCategory,
    required this.subCategories,
    required this.categories,
    this.updateSubCategory,
    this.height = 50,
    this.horizontalPadding = 15,
    this.backgroundColor = Colors.white,
    this.fontSize = 13,
    this.selectedCategoryColor = Colors.red,
    this.textColor = Colors.grey,
    this.selectedSubCategoryColor = Colors.black,
    this.unselectedCategoryColor = Colors.grey,
    this.unselectedSubCategoryColor = Colors.grey,
    this.fontFamily = 'roboto',
    this.animationDuration = 800,
  })  : assert(subCategories is List<List<String>>),
        assert(categories.length == subCategories.length),
        super(key: key);

  @override
  _MenuInlineFilterState createState() => _MenuInlineFilterState();
}

class _MenuInlineFilterState extends State<MenuInlineFilter>
    with TickerProviderStateMixin {
  // horizontal offset of menu filter
  double _horizontalOffset = 0;
  // animation controller
  late AnimationController _controller;
  // animation
  late Animation<double> _animation;
  // menu items global keys
  late List<GlobalKey> _globalKeys;
  // MenuCategoryAppBarItemExpandable global key
  final _menuFilterKey = GlobalKey();
  // TODO divide by 0 later on
  // size of MenuCategoryAppBarItemExpandable widget
  double _filterSizeWidth = 0;
  // size of individual menu item
  double _menuItemSize = 0;
  // check if any item from menu filter is selected
  bool _isCurrentItemShown = false;
  // scroll controller
  final _scrollController = ScrollController();
  // current category index
  int _selectedCategoryIndex = 0;
  // current subcategory index
  int _selectedSubCategoryIndex = 0;
  // current selected subcategory
  String _selectedSubcategory = '';

  @override
  void initState() {
    super.initState();
    _globalKeys = widget.categories
        .map((value) => GlobalKey(debugLabel: value.toString()))
        .toList();
    WidgetsBinding.instance!.addPostFrameCallback(_getMenuFilterSize);
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.animationDuration),
      vsync: this,
    );
    _animation =
        Tween(begin: 1.0, end: 1 / _horizontalOffset).animate(_controller);
  }

  // change category index
  void _changeSelectedCategoryIndex(int value) {
    setState(() {
      _selectedCategoryIndex = value;
    });
  }

  // change subcategory index
  void _changeSelectedSubCategoryIndex(int value) {
    setState(() {
      _selectedSubCategoryIndex = value;
    });
  }

  // change subcategory
  void _changeSelectedSubCategory(String value) {
    setState(() {
      _selectedSubcategory = value;
    });
  }

  // get total width of expandable menu filter
  void _getMenuFilterSize(Duration duration) {
    final RenderBox? box =
        _menuFilterKey.currentContext!.findRenderObject() as RenderBox?;
    setState(() {
      _filterSizeWidth = box!.size.width;
    });
  }

  // change menu filter horizontal offset
  void _changeHorizontalOffset() {
    // TODO box can be null
    final RenderBox box = _globalKeys[_selectedCategoryIndex]
        .currentContext!
        .findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero);

    setState(() {
      _horizontalOffset = -position.dx +
          widget.horizontalPadding -
          _scrollController.position.pixels;
    });

    // scroll menu filter to beginning of scroll
    _scrollController.animateTo(0.0,
        duration: Duration(milliseconds: widget.animationDuration),
        curve: Curves.linear);

    _controller.forward().then((value) => {
          // show static current menu item
          setState(() {
            _isCurrentItemShown = true;
          })
        });
  }

  // get size of individual menu Item
  void _getItemSize(String category) {
    final RenderBox? box = _globalKeys[_selectedCategoryIndex]
        .currentContext!
        .findRenderObject() as RenderBox?;

    setState(() {
      _menuItemSize = box!.size.width;
      _animation = Tween(begin: 1.0, end: _menuItemSize / _filterSizeWidth)
          .animate(_controller);
    });
  }

  // reset menu filter to original position
  void _resetOffset() {
    // make current item invisible
    setState(() {
      _isCurrentItemShown = false;
    });

    setState(() {
      _horizontalOffset = 0;
    });

    _controller.reverse();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _scrollController.dispose();
  }

  // get subcategory test color based on menu filter state
  Color _getSubCategoryTextColor(String subCategory) {
    return _selectedSubcategory == ''
        ? widget.unselectedCategoryColor
        : widget.subCategories[_selectedCategoryIndex].indexOf(subCategory) ==
                _selectedSubCategoryIndex
            ? widget.selectedSubCategoryColor
            : widget.unselectedSubCategoryColor;
  }

  // get category test color based on menu filter state
  Color _getCategoryTextColor(String category) {
    return widget.categories.indexOf(category) == _selectedCategoryIndex
        ? widget.selectedCategoryColor
        : widget.unselectedCategoryColor;
  }

  @override
  Widget build(BuildContext context) {
    return MenuInlineFilterProvider(
      fontFamily: widget.fontFamily,
      fontSize: widget.fontSize,
      height: widget.height,
      child: Container(
        height: widget.height,
        padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
        color: widget.backgroundColor,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizeTransition(
                    axis: Axis.horizontal,
                    sizeFactor: _animation,
                    axisAlignment: -1,
                    child: Stack(
                      children: [
                        Container(
                          width: _filterSizeWidth,
                        ),
                        AnimatedPositioned(
                          duration:
                              Duration(milliseconds: widget.animationDuration),
                          left: _horizontalOffset,
                          child: Row(
                            key: _menuFilterKey,
                            children: [
                              Row(
                                  children: widget.categories
                                      .map(
                                        (category) => MenuCategoryAppBarItem(
                                          index: widget.categories
                                              .indexOf(category),
                                          changeSelectedCategoryIndex:
                                              _changeSelectedCategoryIndex,
                                          key: _globalKeys[widget.categories
                                              .indexOf(category)],
                                          getItemSize: _getItemSize,
                                          selectedCategory: widget.categories[
                                              _selectedCategoryIndex],
                                          resetHorizontalOffset: _resetOffset,
                                          changeMenuFilterOffset:
                                              _changeHorizontalOffset,
                                          title: category,
                                          updateCategory: widget.updateCategory,
                                          textColor:
                                              _getCategoryTextColor(category),
                                          menuItemCategory: category,
                                        ),
                                      )
                                      .toList()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const vd.VerticalDivider(),
                  // SUBCATEGORIES
                  Row(
                    children: widget.subCategories[_selectedCategoryIndex]
                        .map(
                          (subcategory) => MenuSubCategoryAppBarItem(
                              index: widget
                                  .subCategories[_selectedCategoryIndex]
                                  .indexOf(subcategory),
                              title: subcategory,
                              textColor: _getSubCategoryTextColor(subcategory),
                              updateSubCategory: widget.updateSubCategory,
                              selectedSubCategory: subcategory,
                              changeSelectedSubCategoryIndex:
                                  _changeSelectedSubCategoryIndex,
                              changeSelectedSubCategory:
                                  _changeSelectedSubCategory),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            // CURRENT SELECTED MENU ITEM
            Positioned(
              left: 0,
              child: _isCurrentItemShown
                  ? Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          MenuAppBarItem(
                            onTapDown: (details) {
                              _scrollController
                                  .animateTo(0.0,
                                      duration: Duration(
                                          milliseconds:
                                              widget.animationDuration),
                                      curve: Curves.linear)
                                  .then((value) => _resetOffset());
                              // remove selection from subcategory when menu filter closed
                              setState(() {
                                _selectedSubcategory = '';
                              });
                            },
                            title: widget.categories[_selectedCategoryIndex],
                            textColor: widget.selectedCategoryColor,
                          ),
                          const vd.VerticalDivider(),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
