import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:numberpicker/numberpicker.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/setup/setWeightPage.dart';
import 'package:samla_app/features/setup/userMeasurment.dart';

class HeightWidget extends StatefulWidget {
  const HeightWidget(this.height, this.width, this.callback, {Key? key})
      : super(key: key);
  final double height;
  final double width;
  final Function(double) callback;

  @override
  _HeightWidgetState createState() => _HeightWidgetState();
}

class _HeightWidgetState extends State<HeightWidget> {
  int hunderdsDigitValue = 0;
  int tensDigitValue = 0;
  int onesDigitValue = 0;

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Image.asset(
            'images/SelectHight-pic.png',
            height: widget.height * 0.4,

          ),
        ),
      
        Column(
          children: [
            Text(
              "Enter your Height",
              style: TextStyle(
                  color: theme_darkblue.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                  fontSize: 26),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _numberPickerBuilder(hunderdsDigitValue, (newValue) {
                  setState(() {
                    hunderdsDigitValue = newValue;
                  });
                }),
                const SizedBox(width: 10),
                _numberPickerBuilder(tensDigitValue, (newValue) {
                  setState(() {
                    tensDigitValue = newValue;
                  });
                }),
                const SizedBox(width: 10),
                _numberPickerBuilder(onesDigitValue, (newValue) {
                  setState(() {
                    onesDigitValue = newValue;
                  });
                }),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
       
        Container(
          height: 67,
          width: 67,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16),
              elevation: 4, //shadow
              backgroundColor: Colors.white,
            ),
            onPressed: () {
              widget.callback((hunderdsDigitValue * 100 +
                      tensDigitValue * 10 +
                      onesDigitValue)
                  .toDouble());
            },
            child: const Icon(
              Icons.arrow_forward_ios,
              size: 35,
              color: Color(0xFF0A2C40),
            ),
          ),
        ),
         SizedBox(
          height: 50,
        ), 
      ],
    );
  }

  NumberPicker _numberPickerBuilder(value, callback) {
    return NumberPicker(
      value: value,
      textStyle: TextStyle(color: theme_darkblue, fontSize: 12),
      itemWidth: 80,
      itemHeight: 60,
      selectedTextStyle: TextStyle(
        color: theme_darkblue.withOpacity(0.9),
        fontWeight: FontWeight.bold,
        fontSize: 26,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 2,
            color: theme_darkblue.withOpacity(0.3),
          ),
          bottom: BorderSide(
            width: 2,
            color: theme_darkblue.withOpacity(0.3),
          ),
        ),
      ),
      minValue: 0,
      maxValue: 9,
      // value: intHeightValue,
      onChanged: (newValue) {
        callback(newValue);
      },
    );
  }
}
