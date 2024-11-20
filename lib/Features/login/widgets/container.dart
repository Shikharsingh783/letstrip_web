import 'dart:async';

import 'package:flutter/material.dart';
import 'package:letstrip/common_widgets/helper_widget.dart';
import 'package:letstrip/repositories/auth_repo.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginContainer extends StatefulWidget {
  const LoginContainer({super.key});

  @override
  State<LoginContainer> createState() => _ContainerState();
}

class _ContainerState extends State<LoginContainer> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Key for the form
  late StreamController<int> _timerController;
  int timerSeconds = 30;
  bool isTimerRunning = false;
  late Timer _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (timerSeconds == 0) {
        isTimerRunning = false;
        _timer.cancel();
      } else {
        setState(() {
          timerSeconds--;
          _timerController.add(timerSeconds);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _timerController.close();
    emailController.dispose(); // Dispose the controller to avoid memory leaks
    super.dispose();
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty'; // Error for empty email
    }
    // Regular expression for email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email'; // Error for invalid email
    }
    return null; // Return null if the email is valid
  }

  void onSignInPressed(BuildContext localContext) async {
    final email = emailController.text;
    final error = emailValidator(email); // Validate the email field

    if (error != null) {
      // If there's an error, show it in the ScaffoldMessenger
      ScaffoldMessenger.of(localContext).showSnackBar(
        SnackBar(
          content: Text(error), // Display the specific error message
          backgroundColor: Colors.red, // Error message color
        ),
      );
    } else {
      // If validation passes, proceed with OTP sending logic
      try {
        final data = {'email': email}; // Prepare the data to send OTP
        final authService = AuthService(); // Create an instance of AuthService
        final response = await authService.sendOtp(data); // Send OTP

        // Check the response status and handle accordingly
        if (response.success) {
          ScaffoldMessenger.of(localContext).showSnackBar(
            const SnackBar(
              content: Text('OTP sent successfully!'),
              backgroundColor: Colors.green, // Success message color
            ),
          );
          // Optionally navigate to the OTP verification screen
          // Navigator.pushReplacementNamed(context, '/verifyOtp');
        } else {
          ScaffoldMessenger.of(localContext).showSnackBar(
            SnackBar(
              content: Text(response.message ?? 'Error sending OTP'),
              backgroundColor: Colors.red, // Error message color
            ),
          );
        }
      } catch (ex) {
        print(ex);
        // If any exception occurs, show the error message
        ScaffoldMessenger.of(localContext).showSnackBar(
          SnackBar(
            content: Text('Error: $ex'),
            backgroundColor: Colors.red, // Error message color
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) => DeskTopContainer(),
    );
  }

  Widget DeskTopContainer() {
    return Row(
      children: [
        Flexible(
          flex: 5,
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 70.0, top: 30),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/unnamed 1.png',
                        height: 35,
                        width: 35,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Builder(builder: (BuildContext context) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/Hi, Welcome!.png',
                                width: 200,
                              ),
                              const SizedBox(width: 7),
                              Image.asset(
                                'assets/image 297.png',
                                width: 36,
                                height: 36,
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),
                          TextFormField(
                            controller: emailController,
                            cursorColor: Colors.grey,
                            cursorHeight: 20,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 20,
                              ),
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 10),
                                child: vector('assets/email.svg', height: 14),
                              ),
                              hintText: 'Email',
                              hintStyle: const TextStyle(
                                fontFamily: 'Raleway',
                                color: Color.fromRGBO(102, 102, 102, 1),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(228, 228, 228, 1),
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(58, 185, 111, 1),
                                ),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            validator: emailValidator, // Apply the validator
                          ),
                          const SizedBox(height: 30),
                          GestureDetector(
                            onTap: () {
                              onSignInPressed(
                                  context); // Use the Builder context
                            }, // Handle button press
                            child: Container(
                              height: 61,
                              width: 530,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(58, 185, 111, 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text(
                                  'Sign in with OTP',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Raleway',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          const Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Color.fromRGBO(102, 102, 102, 1),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Or continue with',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(102, 102, 102, 1),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Color.fromRGBO(102, 102, 102, 1),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/google_logo.png',
                                height: 37,
                                width: 38,
                              ),
                              const SizedBox(width: 8),
                              Image.asset(
                                'assets/apple.png',
                                height: 37,
                                width: 38,
                              ),
                              const SizedBox(width: 8),
                              Image.asset(
                                'assets/gmail.png',
                                height: 37,
                                width: 38,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 6,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/pexels-arthousestudio-4572311 1.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
