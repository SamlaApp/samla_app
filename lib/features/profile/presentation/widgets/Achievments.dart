import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

class Achievments extends StatefulWidget {
  const Achievments({
    super.key,
    required this.challengeName,
  });

  final String challengeName;

  @override
  State<Achievments> createState() => _Achievments();
}

class _Achievments extends State<Achievments> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
      decoration: primary_decoration,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Achievments",
            style:
                textStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Row(
          children: [
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image(
                      image: AssetImage('images/Logo/1x/Icon_1@1x.png'),
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Running 10 Km in a weak',
                        style: textStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: theme_darkblue.withOpacity(0.5))),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Image(
                      image: AssetImage('images/Logo/1x/Icon_1@1x.png'),
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Running 10 Km in a weak',
                        style: textStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: theme_darkblue.withOpacity(0.5))),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Image(
                      image: AssetImage('images/Logo/1x/Icon_1@1x.png'),
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Running 10 Km in a weak',
                        style: textStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: theme_darkblue.withOpacity(0.5))),
                  ],
                ),
              ],
            ),
            Spacer(),
          ],
        )
      ]),
    );
  }
}
