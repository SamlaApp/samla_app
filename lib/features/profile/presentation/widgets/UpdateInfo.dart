import 'package:flutter/material.dart';
import 'package:samla_app/features/profile/presentation/widgets/AppBar_Widget01.dart';
import 'package:samla_app/features/profile/presentation/widgets/appBar_widget.dart';

class UpdateInfo extends StatefulWidget {
  const UpdateInfo({
    super.key,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
  });

  final String name;
  final String username;
  final String email;
  final String phone;

  @override
  State<UpdateInfo> createState() => _UpdateInfoState();
}

class _UpdateInfoState extends State<UpdateInfo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: buildAAppBar(),
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('./images/Life.jpeg'),
              ),
              Text(
                'Game Monk',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'Flutter Student',
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Source Sans Pro',
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.5),
              ),
              SizedBox(
                width: 150.0,
                height: 20.0,
                child: Divider(
                  color: Colors.teal,
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.teal,
                  ),
                  title: Text(
                    '+91 1234 567890',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Source Sans Pro',
                        color: Colors.teal),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.teal,
                  ),
                  title: Text(
                    'keertirajmalik@gmail.com',
                    style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        fontSize: 20.0,
                        color: Colors.teal),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: PersonalInfoPage(),
//     );
//   }
// }
//
// class PersonalInfoPage extends StatefulWidget {
//   @override
//   _PersonalInfoPageState createState() => _PersonalInfoPageState();
// }
//
// class _PersonalInfoPageState extends State<PersonalInfoPage> {
//   // Sample user data
//   String userName = 'John Doe';
//   String userEmail = 'john.doe@example.com';
//   String userPhone = '+1 (123) 456-7890';
//
//   // Edit mode flag
//   bool isEditing = false;
//
//   // Controllers for editing fields
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     nameController.text = userName;
//     emailController.text = userEmail;
//     phoneController.text = userPhone;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Personal Info'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(isEditing ? Icons.save : Icons.edit),
//             onPressed: () {
//               setState(() {
//                 if (isEditing) {
//                   // Save changes
//                   userName = nameController.text;
//                   userEmail = emailController.text;
//                   userPhone = phoneController.text;
//                 }
//                 isEditing = !isEditing;
//               });
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Name',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18.0,
//               ),
//             ),
//             isEditing
//                 ? TextField(
//                     controller: nameController,
//                   )
//                 : Text(userName),
//             SizedBox(height: 16.0),
//             Text(
//               'Email',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18.0,
//               ),
//             ),
//             isEditing
//                 ? TextField(
//                     controller: emailController,
//                   )
//                 : Text(userEmail),
//             SizedBox(height: 16.0),
//             Text(
//               'Phone',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18.0,
//               ),
//             ),
//             isEditing
//                 ? TextField(
//                     controller: phoneController,
//                   )
//                 : Text(userPhone),
//           ],
//         ),
//       ),
//     );
//   }
// }
