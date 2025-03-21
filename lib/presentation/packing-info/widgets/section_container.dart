import 'package:flutter/material.dart';
import '../../../core/app_styles.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const SectionContainer({
    Key? key,
    required this.child,
    this.padding = AppStyles.sectionPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
