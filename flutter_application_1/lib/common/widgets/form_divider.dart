import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';
// Row

class TFom_divider extends StatelessWidget {
  const TFom_divider({super.key, required this.dividerText});

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Divider(
        color: dark ? TColors.darkGrey : TColors.grey,
        thickness: 0.5,
        indent: 5,
        endIndent: 60);
  }
}

class TFormDivider extends StatelessWidget {
  const TFormDivider({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Divider(
        color: dark ? TColors.darkGrey : TColors.grey,
        thickness: 0.5,
        indent: 60,
        endIndent: 5);
  }
}
