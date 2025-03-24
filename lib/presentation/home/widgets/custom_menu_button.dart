import 'package:flutter/material.dart';
import '../../../core/pallets.dart';

class CustomMenuButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final EdgeInsets padding;

  const CustomMenuButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1.8),
            borderRadius: BorderRadius.circular(8.0),
          ),
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
              color: Pallets.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
