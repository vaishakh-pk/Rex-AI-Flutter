
import 'package:flutter/material.dart';
import 'package:rex_ai/pallete.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String headerText;
  final String descriptionText;
  const FeatureBox({super.key,
  required this.color,
  required this.headerText,
  required this.descriptionText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 30
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15,bottom: 20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(headerText,style: const TextStyle(
                fontFamily: 'Cera Pro',
                color: Pallete.blackColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.only(right:10.0),
              child: Text(descriptionText,style: const TextStyle(
                fontFamily: 'Cera Pro',
                color: Pallete.blackColor,
                fontSize: 14,
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}