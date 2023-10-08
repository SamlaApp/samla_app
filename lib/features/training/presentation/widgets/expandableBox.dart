import '../../../../config/themes/common_styles.dart';
import 'package:flutter/material.dart';
class ExpandableBox extends StatefulWidget {
  final Widget child;
  final String title;

  const ExpandableBox({required this.child, required this.title});

  @override
  _ExpandableBoxState createState() => _ExpandableBoxState();
}

class _ExpandableBoxState extends State<ExpandableBox> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: primary_color,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [boxShadow],
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
            title: Text(widget.title, style: greyTextStyle.copyWith(fontSize: 16)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
          ],
        ),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
          AnimatedCrossFade(
            firstChild: Container(height: 4.0),  // Minimal height container when collapsed
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
              child: widget.child,
            ),
            crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 200),
            alignment: Alignment.topCenter,
          ),
        ],
      ),
    );
  }
}
