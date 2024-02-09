import 'package:flutter/material.dart';

class DetailsRow extends StatelessWidget {
  const DetailsRow({
    super.key,
    required this.detailsTypeValue,
    required this.detailsTypeText,
    required this.imageName,
  });

  final String detailsTypeValue;
  final String detailsTypeText;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/$imageName.png',
              width: 35,
              height: 35,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              detailsTypeText,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: 'Merriweather'),
            ),
          ],
        ),
        Text(
          detailsTypeValue,
          style: const TextStyle(
              fontSize: 30, color: Colors.black, fontFamily: 'Oswald'),
        ),
      ],
    );
  }
}