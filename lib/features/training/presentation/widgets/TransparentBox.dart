import 'package:flutter/material.dart';

import '../../../../config/themes/common_styles.dart';
class TransparentBox extends StatelessWidget {
  final Widget child;

  const TransparentBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 16),
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      decoration: primary_decoration,
      child: child,
    );
  }
}