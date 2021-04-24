import 'package:flutter/material.dart';

class VerticalDivider extends StatelessWidget {
  const VerticalDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 9),
      height: 17,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 2.0,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
