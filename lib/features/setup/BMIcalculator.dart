import 'package:samla_app/features/auth/auth_injection_container.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/auth/data/models/user_model.dart';

double calculateBMI(double newWeight, double newHeight) {
  double heightInMeters =
      newHeight / 100; // Convert height from centimeters to meters
  if (heightInMeters * heightInMeters == 0) return 0;
  return newWeight / (heightInMeters * heightInMeters);
}

String getBMIcategory(double bmi) {
  if (bmi < 18.5) {
    return 'Underweight';
  } else if (bmi >= 18.5 && bmi < 24.9) {
    return 'Normal weight';
  } else if (bmi >= 25 && bmi < 29.9) {
    return 'Overweight';
  } else {
    return 'Obesity';
  }
}
