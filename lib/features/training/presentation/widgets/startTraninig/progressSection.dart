import 'package:flutter/material.dart';

import '../../../../../config/themes/new_style.dart';

class ProgressSection extends StatelessWidget {
  final int totalSets;
  final int finishedSets;
  final int countdownValue;
  final Function startCountdown;
  final TextEditingController kilogramsController;
  final TextEditingController repeatsController;
  final GlobalKey<FormState> formKey;
  final Function(int) updateTotalSets;
  final Function(int) formatTime;

  const ProgressSection({
    super.key,
    required this.totalSets,
    required this.finishedSets,
    required this.countdownValue,
    required this.startCountdown,
    required this.kilogramsController,
    required this.repeatsController,
    required this.formKey,
    required this.updateTotalSets,
    required this.formatTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: LinearGradient(
          colors: [themePink, themeDarkBlue],
          tileMode: TileMode.clamp,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            buildNumber(context),
            Divider(),
            Form(
              key: formKey,
              child: buildForm(context),
            ),
            TextButton.icon(
              onPressed: () => updateTotalSets(totalSets + 1),
              icon: Icon(Icons.add, size: 16.0, color: themeBlue),
              label: Text("Add Set",
                  style: TextStyle(
                    fontSize: 14,
                    color: themeBlue,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNumber(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
      // Assume primary_decoration is defined elsewhere
      decoration: primaryDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildButton(
            context,
            '10',
            'Repeats',
          ),
          buildButton(
            context,
            formatTime(countdownValue),
            'Rest',
          ),
          buildButton(
            context,
            '${finishedSets}/${totalSets}',
            'Sets',
          )
        ],
      ),
    );
  }

  Widget buildButton(BuildContext context, String numbers, String text) {
    return MaterialButton(
      onPressed: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            numbers,
            // Assume theme_green is defined elsewhere
            style: TextStyle(fontSize: 18, color: themeBlue),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: buildTextField(kilogramsController, 'Kilograms'),
            ),
            SizedBox(width: 16),
            Expanded(
              child: buildTextField(repeatsController, 'Repeats'),
            ),
            buildSubmitButton(context),
          ],
        ),
      ],
    );
  }

  Widget buildTextField(TextEditingController controller, String hint) {
    // decoration varable text failed to take numbers only input
    final textFieldDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: white,
      // hint color
      
    );
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 5, 0),
      height: 50,
      // Assume textField_decoration is defined elsewhere
      decoration: textFieldDecoration,
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget buildSubmitButton(BuildContext context) {
    return Container(
      child: TextButton(
        child: Icon(
          Icons.done,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          if (formKey.currentState != null) {
            formKey.currentState!.validate();
          }

          if (kilogramsController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please enter kilograms'),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            startCountdown();
            updateTotalSets(finishedSets + 1);
            kilogramsController.clear();
            repeatsController.clear();
          }
        },
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        // Assume theme_green is defined elsewhere
        color: themeBlue,
      ),
    );
  }
}
