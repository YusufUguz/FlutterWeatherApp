import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 3,
      color: Colors.black,
      endIndent: 10,
      indent: 10,
    );
  }
}