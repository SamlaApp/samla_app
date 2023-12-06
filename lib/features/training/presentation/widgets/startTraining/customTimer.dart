import 'package:flutter/material.dart';

import '../../../../../config/themes/new_style.dart';

class CustomTimerWidget extends StatefulWidget {
  final VoidCallback onClose;

  const CustomTimerWidget({Key? key, required this.onClose}) : super(key: key);

  @override
  _CustomTimerWidgetState createState() => _CustomTimerWidgetState();
}

class _CustomTimerWidgetState extends State<CustomTimerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int _remainingTime = 45;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: _remainingTime),
    );

    _animation = Tween(begin: 1.0, end: 0.0).animate(_animationController)
      ..addListener(() {
        setState(() {
          _remainingTime = 45 - (_animationController.value * 45).round();
        });
      });

    _animationController.reverse(from: 1.0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: widget.onClose, // Close button handler
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: _animation.value,
                  color: themeDarkBlue,
                  backgroundColor: themeBlue,
                ),
              ),
              Text(
                _remainingTime == 0 ? '45' : '$_remainingTime',
                style: TextStyle(fontSize: 28, color: themeGrey),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Great job! Take a rest for 45 seconds.',
            style: TextStyle(color: Colors.black87, fontSize: 18),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
