import 'package:flutter/material.dart';

import '../../../core/app_styles.dart';


class CustomBottomSheetContent extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;

  const CustomBottomSheetContent({
    Key? key,
    required this.title,
    required this.content,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: AppStyles.sectionPadding,
              child: Text(title, style: AppStyles.bottomSheetTitle),
            ),
            const Divider(height: 1, color: Colors.grey),
            Padding(
              padding: AppStyles.bottomSheetContentPadding,
              child: content,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}