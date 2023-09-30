import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:samla_app/config/themes/common_styles.dart';

class DailyChallenge extends StatefulWidget {
  const DailyChallenge(
      {super.key,
      required this.challengeName,
      required this.challengeProgress,
      required this.challengeImage,
      required this.statusUpdate});

  final String challengeName;
  final String challengeProgress;
  final String challengeImage;
  final Function() statusUpdate;

  @override
  State<DailyChallenge> createState() => _DailyChallengeState();
}

class _DailyChallengeState extends State<DailyChallenge> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20,15,20,15),
      // width: double.infinity,
      decoration: primary_decoration,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Daily Challenge",
            style:
                textStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Row(
          children: [
            SvgPicture.asset(
              widget.challengeImage,
              color: theme_green,
              height: 42,
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.challengeName,
                    style: textStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: theme_darkblue.withOpacity(0.5))),
                                SizedBox(height: 3),

                Text(widget.challengeProgress,
                    style: textStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: theme_darkblue.withOpacity(0.5)))
              ],
            ),
            Spacer(),
            SizedBox(
              height: 32,
              width: 83,
              child: TextButton(
                onPressed: () {
                  widget.statusUpdate();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(theme_green),
    
                ),
                child: Text("DONE",
                    style: textStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primary_color)),
              ),
            )
          ],
        )
      ]),
    );
  }
}
