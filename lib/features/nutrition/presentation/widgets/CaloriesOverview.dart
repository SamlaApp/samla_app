import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../nutrition/presentation/widgets/CircularIndicators.dart';

class CaloriesOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircularIndicators(),
        SizedBox(width: 10),
      ],
    );
  }
}