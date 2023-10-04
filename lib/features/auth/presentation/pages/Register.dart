import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:samla_app/config/themes/common_styles.dart';
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
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? _accountType;

  final List<String> _accountTypeList = ['User', 'Trainer'];

  _Register(){
    final http.Client client = http.Client();

    late RemoteDataSourceImpl remoteDataSourceImpl =
        RemoteDataSourceImpl(client: client);
    late SharedPreferences sharedPreferences;
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
                ),),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Name
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(64, 194, 210, 1),
                              ),
                            ),
                            prefixIcon: const Icon(Icons.person,
                                color: Color.fromRGBO(64, 194, 210, 1)),
                            hintText: 'Name',
                            labelText: 'Name',
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
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),

                        // Username
                        SizedBox(height: MediaQuery.of(context).size.height * x),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(64, 194, 210, 1),
                              ),
                            ),
                            prefixIcon: const Icon(Icons.account_circle,
                                color: Color.fromRGBO(64, 194, 210, 1)),
                            hintText: 'Username',
                            labelText: 'Username',
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
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),

                        // Email
                        SizedBox(height: MediaQuery.of(context).size.height * x),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(64, 194, 210, 1),
                              ),
                            ),
                            prefixIcon: const Icon(Icons.email,
                                color: Color.fromRGBO(64, 194, 210, 1)),
                            hintText: 'Email',
                            labelText: 'Email',
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
                        SizedBox(height: MediaQuery.of(context).size.height * x),
                        InternationalPhoneNumberInput(
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          onInputChanged: (PhoneNumber number) {
                            _phoneController.text = number.phoneNumber!;
                          },
                          initialValue: PhoneNumber(isoCode: 'SA'),
                          textFieldController: TextEditingController(),
                          keyboardType: TextInputType.phone,
                          inputDecoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(64, 194, 210, 1),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(64, 194, 210, 1),
                              ),
                            ),
                            labelText: 'Mobile Number',
                          ),
                        ),

                        // Date of Birth
                        SizedBox(height: MediaQuery.of(context).size.height * x),
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
                        SizedBox(height: MediaQuery.of(context).size.height * x),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(64, 194, 210, 1),
                              ),
                            ),
                            prefixIcon: const Icon(Icons.key,
                                color: Color.fromRGBO(64, 194, 210, 1)),
                            hintText: 'Password',
                            labelText: 'Password',
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
                          obscureText: true,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),

                        // Select Account Type
                        SizedBox(height: MediaQuery.of(context).size.height * x),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(64, 194, 210, 1),
                              ),
                            ),
                            prefixIcon: const Icon(Icons.group,
                                color: Color.fromRGBO(64, 194, 210, 1)),
                            hintText: 'Account Type',
                            labelText: 'Account Type',
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
                          value: _accountType,
                          items: _accountTypeList.map((accountType) {
                            return DropdownMenuItem(
                              value: accountType,
                              child: Text('$accountType'),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _accountType = value.toString();
                            });
                          },
                        ),

                        // Register Button
                        SizedBox(height: MediaQuery.of(context).size.height * x),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor:
                            const Color.fromRGBO(64, 194, 210, 1),
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
              Container(

                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Are you a Gym Owner? ',
                      style: TextStyle(
                        color: Color.fromRGBO(10, 44, 64, 1),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * x ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Register as a Gym Owner',
                        style: TextStyle(
                          color: Color.fromRGBO(64, 194, 210, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * x *2.5),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
