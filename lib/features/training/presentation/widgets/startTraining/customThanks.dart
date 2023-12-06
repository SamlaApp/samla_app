import 'package:flutter/material.dart';

import '../../../../../config/themes/new_style.dart';

Future<bool?> showThankYouDialog(
    BuildContext context,
    AnimationController smallStarController1,
    AnimationController largeStarController,
    AnimationController smallStarController2) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // reduse the padding
        contentPadding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeTransition(
                  opacity: smallStarController1,
                  child: const Icon(Icons.star_rate,
                      size: 22, color: themeBlue), // Smaller star
                ),
                FadeTransition(
                  opacity: largeStarController,
                  child: const Icon(Icons.star_rate,
                      size: 45, color: themeBlue), // Larger star
                ),
                FadeTransition(
                  opacity: smallStarController2,
                  child: const Icon(Icons.star_rate,
                      size: 22, color: themeBlue), // Smaller star
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Training Completed!",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: const Text(
          "Congratulations! You've completed today's training session. Great job!",
          style: TextStyle(color: Colors.black87, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("Close", style: TextStyle(color: themeBlue)),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
