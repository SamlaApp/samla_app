import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:samla_app/core/auth/User.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/network/network_info.dart';
import 'package:samla_app/features/auth/data/datasources/local_data_source.dart';
import 'package:samla_app/features/auth/data/datasources/remote_data_source.dart';
import 'package:samla_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:samla_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:samla_app/features/auth/presentation/pages/OTP.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int _selectedIndex = 0; // 0 for Email, 1 for Username, 2 for Phone
  final http.Client client = http.Client();

  late RemoteDataSourceImpl remoteDataSourceImpl =
      RemoteDataSourceImpl(client: client);
  late SharedPreferences sharedPreferences;

  late LocalDataSourceImpl localDataSourceImpl =
      LocalDataSourceImpl(sharedPreferences: sharedPreferences);
  // Login via Email
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _emailPasswordController =
      TextEditingController();

  // Login via Username
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _usernamePasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  // Login via Phone
  // PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'SA');
  String _phone = '';
  bool _isPhoneLoginEnable = false;

  void _loginViaPhone() async {
    try {
      await remoteDataSourceImpl
          .loginWithPhoneNumber(_phone);
      print('phone number');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPPage(
            phone: _phone,
          ),
        ),
      );
    } on ServerException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('something went worng'),
        ),
      );
    }
  }

  Future<void> _loginViaUsername() async {
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      // Trim the username
      final username = _usernameController.text.trim();

      // Trim the password
      final password = _usernamePasswordController.text.trim();

      final userModel =
          await remoteDataSourceImpl.loginWithUsername(username, password);

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

  Future<void> _loginViaEmail() async {
      sharedPreferences = await SharedPreferences.getInstance();
    try {
      // Trim the username
      final email = _emailController.text.trim();

      // Trim the password
      final password = _emailPasswordController.text.trim();

      final userModel =
          await remoteDataSourceImpl.loginWithEmail(email, password);

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Material(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Logo Part
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'images/Logo/2x/Icon_1@2x.png',
                          height: 60,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Login to Samla',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(10, 44, 64, 1),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'We’re happy to see you back again!',
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
            
                  // Login Method Part
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Column(
                      children: <Widget>[
                        // 3 Login Methods Buttons
                        Row(
                          children: [
                            // Email Button
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: (_selectedIndex == 0)
                                          ? const Color.fromRGBO(64, 194, 210, 1)
                                          : Colors.grey,
                                      width: 3,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedIndex = 0;
                                    });
                                  },
                                  child: const Text(
                                    'Email',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromRGBO(10, 44, 64, 1),
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
            
                            // Username Button
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: (_selectedIndex == 1)
                                          ? const Color.fromRGBO(64, 194, 210, 1)
                                          : Colors.grey,
                                      width: 3,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedIndex = 1;
                                    });
                                  },
                                  child: const Text(
                                    'Username',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromRGBO(10, 44, 64, 1),
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
            
                            // Phone Button
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: (_selectedIndex == 2)
                                          ? const Color.fromRGBO(64, 194, 210, 1)
                                          : Colors.grey,
                                      width: 3,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedIndex = 2;
                                    });
                                  },
                                  child: const Text(
                                    'Phone',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromRGBO(10, 44, 64, 1),
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
            
                  const SizedBox(height: 40),
            
                  if (_selectedIndex == 0) // Email Login
                    Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
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
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(10, 44, 64, 1),
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _emailPasswordController,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(64, 194, 210, 1),
                              ),
                            ),
                            prefixIcon: const Icon(Icons.lock,
                                color: Color.fromRGBO(64, 194, 210, 1)),
                            hintText: 'Password',
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
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(10, 44, 64, 1),
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Forgot your password?',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromRGBO(10, 44, 64, 1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                            _loginViaEmail();
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    )
                  else if (_selectedIndex == 1) // Username Login
                    Column(
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your username';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(64, 194, 210, 1),
                              ),
                            ),
                            prefixIcon: const Icon(Icons.person,
                                color: Color.fromRGBO(64, 194, 210, 1)),
                            hintText: 'Username',
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
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(10, 44, 64, 1),
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _usernamePasswordController,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(64, 194, 210, 1),
                              ),
                            ),
                            prefixIcon: const Icon(Icons.lock,
                                color: Color.fromRGBO(64, 194, 210, 1)),
                            hintText: 'Password',
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
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(10, 44, 64, 1),
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Forgot your password?',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromRGBO(10, 44, 64, 1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                            _loginViaUsername();
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    )
                  else if (_selectedIndex == 2) // Phone Login
                    Column(
                      children: [
                        InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            print(number.phoneNumber);
                            _phone = number.phoneNumber!;
                          },
                          onInputValidated: (bool value) {
                            print(value);
                            if (value) {
                              setState(() {
                                _isPhoneLoginEnable = true;
                              });
                            } else {
                              setState(() {
                                _isPhoneLoginEnable = false;
                              });
                            }
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
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor:
                                const Color.fromRGBO(64, 194, 210, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _isPhoneLoginEnable
                              ? () {
                                  _loginViaPhone();
                                }
                              : null,
                          child: const Text('Login'),
                        ),
                      ],
                    ),
            
                  // do not have an account? Sign up
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account? ',
                          style: TextStyle(
                            color: Color.fromRGBO(10, 44, 64, 1),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/Register');
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: Color.fromRGBO(64, 194, 210, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
