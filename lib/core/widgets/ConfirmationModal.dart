import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

void showConfirmationModal({

   required BuildContext context,required String message, required Function confirmCallback,
    String? buttonLabel, bool isNegative = true}) {
  showModalBottomSheet(
      backgroundColor: isNegative == true ? themePink : themeBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          child: Column(
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: isNegative == true ? themePink : themeBlue,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                ),
              ),
              // SizedBox(height: 0),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20.0),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(message,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              decoration: TextDecoration.none,
                              color: themeDarkBlue.withOpacity(0.95))),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 40,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          decoration: TextDecoration.none,
                                          color: themeDarkBlue
                                              .withOpacity(0.95))),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 40,
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<
                                            Color>(
                                        isNegative ? themePink : themeBlue),
                                  ),
                                  onPressed: () {
                                    confirmCallback();
                                  },
                                  child: Text(buttonLabel ?? 'Yes',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          decoration: TextDecoration.none,
                                          color:
                                              primary_color.withOpacity(0.95))),
                                ),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      });
}
