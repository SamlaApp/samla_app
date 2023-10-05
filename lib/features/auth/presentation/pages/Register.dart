import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/core/auth/User.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/auth/data/datasources/local_data_source.dart';
import 'package:samla_app/features/auth/data/datasources/remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  static const double x = 0.03;

  // Register form keys
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'SA');
  String _phone = '';
  String? _accountType;

  final http.Client client = http.Client();

  late RemoteDataSourceImpl remoteDataSourceImpl =
      RemoteDataSourceImpl(client: client);
  late SharedPreferences sharedPreferences;

  late LocalDataSourceImpl localDataSourceImpl =
      LocalDataSourceImpl(sharedPreferences: sharedPreferences);

  _Register() async {
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      // Trim the username
      final username = _usernameController.text.trim();

      // Trim the password
      final password = _passwordController.text.trim();
      final email = _emailController.text.trim();
      final phone = _phone;
      final name = _nameController.text.trim();
      final dateOfBirth = _dateController.text.trim();

      print('username: $username');
      print('password: $password');
      print('email: $email');
      print('phone: $phone');
      print('name: $name');
      print('dateOfBirth: $dateOfBirth');

      final userModel = await remoteDataSourceImpl.signup(
        name: name,
        email: email,
        username: username,
        phone: phone,
        dateOfBirth: dateOfBirth,
        password: password,
      );

      await localDataSourceImpl.cacheUser(userModel);
      await LocalAuth.init();
      // Navigator.pushReplacementNamed(context, '/');
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/MainPages', (Route<dynamic> route) => false);
    } on ServerException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('something went worng'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_color,
        elevation: 0,
        title: const Text(
          'Register',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Add your save button functionality here
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * x),

              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Material(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * x),
                      Image.asset(
                        'images/Logo/2x/Icon_1@2x.png',
                        height: 60,
                      ),
                      Text(
                        'Sign Up to Samla',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(10, 44, 64, 1),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * x),
                      const Text(
                        'Welcome to be part of us!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(10, 44, 64, 1),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Name
                        CustomTextField(
                          controller: _nameController,
                          iconData: Icons.person,
                          hintText: 'Name',
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        CustomTextField(
                          controller: _usernameController,
                          iconData: Icons.person,
                          hintText: 'Username',
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            // check if there is space in the username
                            if (value.contains(' ')) {
                              return 'Username must not contain spaces';
                            }
                            return null;
                          },
                        ),

                        // Email
                        SizedBox(
                          height: 10,
                        ),

                        CustomTextField(
                          hintText: 'Email',
                          controller: _emailController,
                          iconData: Icons.email,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(
                                    r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),

                        // Mobile
                        SizedBox(
                          height: 10,
                        ),

                        // InternationalPhoneNumberInput(
                        //   selectorConfig: const SelectorConfig(
                        //     selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        //   ),
                        //   onInputChanged: (PhoneNumber number) {
                        //     print(number.toString());
                        //   },
                        //   initialValue: PhoneNumber(isoCode: 'SA'),
                        //   inputDecoration: InputDecoration(
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(10),
                        //       ),
                        //       borderSide: BorderSide(
                        //         color: theme_green,
                        //       ),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(10),
                        //       ),
                        //       borderSide: BorderSide(color: theme_green),
                        //     ),
                        //     labelText: 'Mobile Number',
                        //   ),
                        // ),
                           InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            print(number.phoneNumber);
                            _phone = number.phoneNumber!;
                          },
                          onInputValidated: (bool value) {
                            print(value);
                          },
                          initialValue: PhoneNumber(isoCode: 'SA'),
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          ignoreBlank: true,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          selectorTextStyle: TextStyle(color: Colors.black),
                          textFieldController: _phoneController,
                          formatInput: false,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          inputBorder: OutlineInputBorder(),
          
                        ),

                        // Date of Birth
                        SizedBox(
                          height: 10,
                        ),

                        // date picker
                        TextFormField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(64, 194, 210, 1),
                              ),
                            ),
                            prefixIcon: const Icon(Icons.date_range,
                                color: Color.fromRGBO(64, 194, 210, 1)),
                            hintText: 'Date of Birth',
                            labelText: 'Date of Birth',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(64, 194, 210, 1),
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
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your date of birth';
                            }
                            return null;
                          },
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              _dateController.text =
                                  DateFormat('yyyy-MM-dd').format(picked);
                            }
                          },
                        ),

                        // Password
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: theme_green,
                              ),
                            ),
                            prefixIcon: Icon(Icons.key, color: theme_green),
                            hintText: 'Password',
                            labelText: 'Password',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: theme_green,
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
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                          ),
                          obscureText: true,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),

                        SizedBox(
                          height: 40,
                        ),

                        // Register Button

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: theme_green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _Register();
                            }
                          },
                          child: const Text('Register'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Register as a Gym Owner
              SizedBox(height: MediaQuery.of(context).size.height * x),
            ],
          ),
        ),
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
            color: theme_green,
          ),
        ),
        prefixIcon: Icon(iconData, color: Color.fromRGBO(64, 194, 210, 1)),
        hintText: hintText,
        labelText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: theme_green,
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
