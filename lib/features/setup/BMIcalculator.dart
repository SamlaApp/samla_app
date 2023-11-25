import 'package:samla_app/features/auth/auth_injection_container.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/auth/data/models/user_model.dart';

// void main() {
//   UserModel.fromEntity(34 as User).height;

//   double? height = getUser().height; //let's say here we will get it from: UserModel.weight();
//   double? weight = getUser().weight; //let's say here we will get it from: UserModel.weight();

//   double bmi = calculateBMI(weight, height);

//   String bmiCatagory = getBMIcategory(bmi);
// }

double calculateBMI(double newWeight, double newHeight) {
  double heightInMeters =
      newHeight / 100; // Convert height from centimeters to meters

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
