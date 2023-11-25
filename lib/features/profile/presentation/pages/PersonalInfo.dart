import 'package:flutter/material.dart';
import 'package:samla_app/config/router/app_router.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart';
import 'package:samla_app/features/profile/presentation/widgets/profile_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PersonalInfoPage(),
    );
  }
}

class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

final user = getUser();

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  // Sample user data
  String userName = user.name;
  String userEmail = user.email;
  String userPhone = user.phone;
  String userNameID = user.username;
  String height = '$user.height';
  String weight = '55';

  // Edit mode flag
  bool isEditing = false;

  // Controllers for editing fields
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = userName;
    emailController.text = userEmail;
    phoneController.text = userPhone;
    userNameController.text = userNameID;
    heightController.text = height;
    weightController.text = weight;
  }

  final String imagePath = 'images/download.jpeg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // shape: BeveledRectangleBorder(
        //   borderRadius: BorderRadius.circular(30),
        // ),
        toolbarHeight: 100,
        backgroundColor: themeDarkBlue,
        title: Image(
          image: AssetImage('images/Logo/2x/Icon_1@2x.png'),
          height: 70,
          width: 70,
          color: Colors.white,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                if (isEditing) {
                  // Save changes
                  userName = nameController.text;
                  userEmail = emailController.text;
                  userPhone = phoneController.text;
                  userNameID = userNameController.text;
                  height = heightController.text;
                  weight = weightController.text;
                }
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(33.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ProfileWidget(
                imageName: imagePath,
                onClicked: () async {},
              ),
              Text(
                'Full Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: themeBlue,
                ),
              ),
              isEditing
                  ? TextField(
                      controller: nameController,
                    )
                  : Container(
                      width: 320,
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                      // width: double.infinity,
                      decoration: textField_decoration,
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.black38,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            userName,
                            style: inputText,
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 16.0),
              Text(
                'Username',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: themeBlue,
                ),
              ),
              isEditing
                  ? TextField(
                      controller: userNameController,
                    )
                  : Container(
                      width: 320,
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                      // width: double.infinity,
                      decoration: textField_decoration,
                      child: Row(
                        children: [
                          Icon(
                            Icons.person_pin,
                            color: Colors.black38,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '@' + userNameID,
                            style: inputText,
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 16.0),
              Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: themeBlue,
                ),
              ),
              isEditing
                  ? TextField(
                      controller: emailController,
                    )
                  : Container(
                      width: 320,
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                      // width: double.infinity,
                      decoration: textField_decoration,
                      child: Row(
                        children: [
                          Icon(
                            Icons.email,
                            color: Colors.black38,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            userEmail,
                            style: inputText,
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 16.0),
              Text(
                'Phne',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: themeBlue,
                ),
              ),
              isEditing
                  ? TextField(
                      controller: phoneController,
                    )
                  : Container(
                      width: 320,
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                      // width: double.infinity,
                      decoration: textField_decoration,
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.black38,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            userPhone,
                            style: inputText,
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Height',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: themeBlue,
                          ),
                        ),
                        isEditing
                            ? TextField(
                                controller: heightController,
                              )
                            : Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                                decoration: textField_decoration,
                                child: Text(
                                  height + ' cm',
                                  style: inputText,
                                ),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Weight',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: themeBlue,
                          ),
                        ),
                        isEditing
                            ? TextField(
                                controller: weightController,
                              )
                            : Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(0, 5, 6, 0),
                                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                                decoration: textField_decoration,
                                child: Text(
                                  weight + ' kg',
                                  style: inputText,
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
