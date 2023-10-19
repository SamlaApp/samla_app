import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:http/http.dart' as http;
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/widgets/loading.dart';
import 'package:samla_app/features/auth/data/datasources/local_data_source.dart';
import 'package:samla_app/features/auth/data/datasources/remote_data_source.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart' as di;

class OTPPage extends StatefulWidget {
  final String phone;

  const OTPPage({Key? key, required this.phone}) : super(key: key);

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  int _timerSeconds = 60;
  int _resendAttempts = 3;
  bool _canResendCode = true;
  String _buttonText = 'Send Code';
  Timer? _timer;
  String _correctOtp = '';
  bool _wrongOtp = false;

  void _startTimer() {
    _timerSeconds = 60;
    _canResendCode = false;

    // Generate OTP code
    String otpCode = (1000 + Random().nextInt(9000)).toString();
    _correctOtp = otpCode;

    // Send the OTP code via SMS
    if (widget.phone != null) {
      //sendSMS(widget.phoneNumber.phoneNumber!, 'Your OTP code is $otpCode');
      print('OTP code is $otpCode');
    } else {
      print('Invalid phone number');
    }

    setState(() {
      if (_resendAttempts > 0) {
        _resendAttempts -= 1;
      }
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timerSeconds -= 1;
        if (_timerSeconds == 0) {
          _timer?.cancel();
          _canResendCode = true;
          _buttonText = 'Send Code';
        } else {
          _buttonText = '$_timerSeconds s';
        }
      });
    });
  }

  late SharedPreferences sharedPreferences;

  late LocalDataSourceImpl localDataSourceImpl =
      LocalDataSourceImpl(sharedPreferences: sharedPreferences);

  final http.Client client = http.Client();

  late RemoteDataSourceImpl remoteDataSourceImpl =
      RemoteDataSourceImpl(client: client);

  final authBloc = di.sl.get<AuthBloc>();

  // void _checkOtp() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   String enteredOtp = '';
  // for (final controller in _controllers) {
  //   enteredOtp += controller.text;
  // }
  //   print('check otp $enteredOtp');
  //   try {
  //     final userModel =
  //         await remoteDataSourceImpl.sendOTP(widget.phone, enteredOtp);
  //     await localDataSourceImpl.cacheUser(userModel);
  //     await LocalAuth.init();
  //     // await LocalAuth.user;
  //     Navigator.pushReplacementNamed(context, '/');
  //   } on ServerException catch (e) {
  //     print('server exception');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('wrong code'),
  //       ),
  //     );
  //   } catch (e) {
  //     print(e.toString());
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Something went wrong'),
  //       ),
  //     );
  //     print('OTP is incorrect');
  //     setState(() => (_wrongOtp = true));
  //   }

  //   // Perform the action you want to execute when the OTP is incorrect
  // }

  _checkOtp() {
    String enteredOtp = '';
    for (final controller in _controllers) {
      enteredOtp += controller.text;
    }
    authBloc.add(CheckOTPEvent(phone: widget.phone, otp: enteredOtp));
  }

  void onNumberButtonPressed(String number) {
    if (number == 'C') {
      clearInput();
      setState(() => (_wrongOtp = false));
    } else {
      int lastFilledIndex = -1;
      for (int i = 0; i < _controllers.length; i++) {
        if (_controllers[i].text.isEmpty) {
          _controllers[i].text = number;
          lastFilledIndex = i;
          break;
        }
      }

      if (lastFilledIndex == _controllers.length - 1) {
        _checkOtp();
      }
    }
  }

  void clearInput() {
    for (final controller in _controllers) {
      if (controller.text.isNotEmpty) {
        controller.text = '';
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget numberButton(String number) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 60,
        height: 60,
        child: OutlinedButton(
          onPressed: () => onNumberButtonPressed(number),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: number == 'C'
              ? const Icon(Icons.backspace_outlined,
                  size: 24, color: Color.fromRGBO(10, 44, 64, 1))
              : Text(
                  number,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Color.fromRGBO(10, 44, 64, 1),
                  ),
                ),
        ),
      ),
    );
  }

  String get _displayText => _canResendCode ? 'Send Code' : _buttonText;

  @override
  Widget build(BuildContext context) {
    // Hide the keyboard
    FocusScope.of(context).unfocus();
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // states handler
        if (state is LoadingAuthState) {
          // Show the loading widget on top of your main widget.
          return Stack(
            children: [
              OTPWidget(context), // Your main content widget
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
        }
        if (state is AuthenticatedState) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/MainPages', (Route<dynamic> route) => false);
          });
        }
        return OTPWidget(context);
      },
    );
  }

  Scaffold OTPWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_color,
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            // padding: const EdgeInsets.all(20),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              children: [
                // Logo Part
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'images/Logo/2x/Icon_1@2x.png',
                        height: 60,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'OTP Verification',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(10, 44, 64, 1),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Enter the code sent to ${widget.phone}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(10, 44, 64, 1),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),

                // OTP Part
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _controllers
                      .asMap()
                      .map(
                        (index, controller) => MapEntry(
                          index,
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: TextFormField(
                              controller: controller,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(1),
                              ],
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width:
                                        2.0, // Set the border width as desired
                                    color: Colors.blue, // Set the border color
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .values
                      .toList(),
                ),

                // Show error message if the OTP is wrong stateful
                const SizedBox(height: 20),
                if (_wrongOtp)
                  const Text(
                    'Wrong OTP code',
                    style: TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 10),
              ],
            ),

            // button part
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_resendAttempts == 3)
                      // confirm this number for the user
                      const Text('This number for you?'),
                    TextButton(
                      onPressed: _canResendCode
                          ? () {
                              setState(() {
                                _startTimer();
                              });
                            }
                          : null,
                      child: Text(
                        (_resendAttempts > 0)
                            ? _displayText
                            : 'No more attempts',
                        style: TextStyle(
                            color: _canResendCode ? Colors.blue : Colors.grey),
                      ),
                    ),
                  ],
                ),
                ...List.generate(3, (index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(3, (subIndex) {
                      final number = index * 3 + subIndex + 1;
                      return numberButton(number.toString());
                    }),
                  );
                }),

                // button part
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // c button as clear icon
                    numberButton('C'),
                    numberButton('0'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const SizedBox(width: 80, height: 80),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
