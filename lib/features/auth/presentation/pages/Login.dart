import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'package:samla_app/core/widgets/loading.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/auth/presentation/pages/OTP.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/features/setup/welcomePage.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int _selectedIndex = 0; // 0 for Email, 1 for Username, 2 for Phone

  final _emailController = TextEditingController();
  final _emailPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _usernamePasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  // map to valid fields in the form
  Map<String, bool> _validFieldsEmail = {
    'email': false,
    'password': false,
  };

  Map<String, bool> _validFieldsUsername = {
    'username': false,
    'password': false,
  };

  String _phone = '';
  bool _isPhoneLoginEnable = false;

  final authBloc = di.sl.get<AuthBloc>();

  _loginViaEmail() {
    authBloc.add(LoginWithEmailEvent(
      email: _emailController.text.trim(),
      password: _emailPasswordController.text.trim(),
    ));
  }

  _loginViaUsername() {
    authBloc.add(LoginWithUsernameEvent(
      username: _usernameController.text.trim(),
      password: _usernamePasswordController.text.trim(),
    ));
  }

  void _loginViaPhone() async {
    authBloc.add(LoginWithPhoneEvent(phone: _phone));
  }



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // states handler
        if (state is LoadingAuthState) {
          // Show the loading widget on top of your main widget.
          return Stack(
            children: [
              LoginWidget(context), // Your main content widget
              Positioned.fill(
                child: Center(
                  child: LoadingWidget(), // Loading widget
                ),
              ),
            ],
          );
        }

        if (state is ErrorAuthState) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          });
          authBloc.add(ClearAuthEvent());
        }
        if (state is AuthenticatedState) {
          if (state.user.hasGoal) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/MainPages', (Route<dynamic> route) => false);
            });
          } else {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const WelcomePage(),
                ),
              );
            });
          }
        }
        if (state is OTPSentState) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OTPPage(
                  phone: _phone,
                ),
              ),
            );
          });
        }
        return LoginWidget(context);
      },
    );
  }

  Scaffold LoginWidget(BuildContext context) {
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
                                          ? const Color.fromRGBO(
                                              64, 194, 210, 1)
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
                                      fontWeight: FontWeight.normal,
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
                                          ? const Color.fromRGBO(
                                              64, 194, 210, 1)
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
                                      fontWeight: FontWeight.normal,
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
                                          ? const Color.fromRGBO(
                                              64, 194, 210, 1)
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
                                      fontWeight: FontWeight.normal,
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
                        Form(
                          key: GlobalKey<FormState>(),
                          child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                _validFieldsEmail['email'] = false;
                                return 'Please enter your email';
                              } else if (!RegExp(
                                      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                                _validFieldsEmail['email'] = false;
                                return 'Please enter a valid email address';
                              }
                              _validFieldsEmail['email'] = true;
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
                              hintStyle: TextStyle(color: themeDarkBlue.withOpacity(0.5)),
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
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _emailPasswordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              _validFieldsEmail['password'] = false;
                              return 'Please enter your password';
                            }
                            _validFieldsEmail['password'] = true;

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
                            hintStyle: TextStyle(color: themeDarkBlue.withOpacity(0.5)),

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
                            print(_validFieldsEmail);
                            if (_validFieldsEmail['email']! &&
                                _validFieldsEmail['password']!) {
                              _loginViaEmail();
                            }
                          },
                          child: const Text('Login', style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    )
                  else if (_selectedIndex == 1) // Username Login
                    Column(
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              _validFieldsUsername['username'] = false;
                              return 'Please enter your username';
                            } else {
                              _validFieldsUsername['username'] = true;
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
                            hintStyle: TextStyle(color: themeDarkBlue.withOpacity(0.5)),

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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              _validFieldsUsername['password'] = false;

                              return 'Please enter your password';
                            }
                            _validFieldsUsername['password'] = true;

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
                            hintStyle: TextStyle(color: themeDarkBlue.withOpacity(0.5)),

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
                            if (_validFieldsUsername['username']! &&
                                _validFieldsUsername['password']!) {
                              _loginViaUsername();
                            }
                          },
                          child: const Text('Login', style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    )
                  else if (_selectedIndex == 2) // Phone Login
                    Column(
                      children: [
                        InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            _phone = number.phoneNumber!;
                          },
                          onInputValidated: (bool value) {
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
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          ignoreBlank: true,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          selectorTextStyle: const TextStyle(color: themeDarkBlue),
                          textStyle: const TextStyle(color: themeDarkBlue),
                          textFieldController: _phoneController,
                          formatInput: false,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          inputBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(64, 194, 210, 1),
                            ),
                          ),
                          inputDecoration:  InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(color: themeDarkBlue.withOpacity(0.5)),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(64, 194, 210, 1),
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                          ),
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
                          child: const Text('Login', style: TextStyle(color: Colors.white),),
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
                            Navigator.pushReplacementNamed(
                                context, '/Register');
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
