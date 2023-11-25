import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:ui';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/core/widgets/CustomTextFormField.dart';

class StepsGoalWidget extends StatefulWidget {
  const StepsGoalWidget(this.height, this.width, this.callback, {Key? key})
      : super(key: key);
  final double height;
  final double width;
  final Function(int) callback;
  @override
  _StepsGoalWidgetState createState() => _StepsGoalWidgetState();
}

class _StepsGoalWidgetState extends State<StepsGoalWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Image.asset(
            'images/StepsGoal-pic.png',
            height: widget.height * 0.3,
          ),

          SizedBox(height: 20,),
      
          Column(
            children: [

              Text(
                "Now let’s set your\n daily steps goal",
                style: TextStyle(
                    color: themeDarkBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: widget.width * 0.8,
                  child: CustomTextFormField(
                    keyboardType: TextInputType.number,
                    controller: controller,
                    
                      label: 'Enter number of stpes',
                      iconData: Icons.directions_walk)),
                      SizedBox(height: 20,)
            ],
          ),
          // ensure there is a space between the text and the button
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
                widget.callback(controller.text.isNotEmpty
                    ? int.parse(controller.text)
                    : 10000);
              },
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 35,
                color: Color(0xFF0A2C40),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;

  const CustomTextField(
      {required TextEditingController this.controller,
      required IconData this.iconData,
      required String this.hintText,
      String? Function(String?)? this.validator});

  final TextEditingController controller;
  final IconData iconData;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: themeBlue,
          ),
        ),
        prefixIcon: Icon(iconData, color: Color.fromRGBO(64, 194, 210, 1)),
        hintText: hintText,
        labelText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: themeBlue,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      validator: validator,
    );
  }
}
