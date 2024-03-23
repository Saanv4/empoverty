import 'dart:async';

import 'package:empoverty/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'homepage.dart';
import 'role_selection_page.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({Key? key, required this.phoneNumber})
      : super(key: key);

  final String phoneNumber;

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  int timerSeconds = 60;
  late final ValueNotifier<int> timerNotifier;

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    timerNotifier = ValueNotifier<int>(timerSeconds);

    // Start the timer
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
          (Timer timer) {
        if (timerSeconds == 0) {
          timer.cancel();
          // Show a pop-up message
          showRedirectMessage();
        } else {
          timerNotifier.value = timerSeconds--;
        }
      },
    );
  }

  void showRedirectMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Redirecting'),
          content: Text('You are being redirected to HomePage.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Redirect to HomePage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showConfirmationMessage() {
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text('Good to go!'),
        backgroundColor: Colors.green, // Set background color to green
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldMessengerKey,
      appBar: AppBar(
        title: const Text('One-Time Password Verification'),
        backgroundColor: Colors.teal,
        elevation: 5,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'OTP Verification for ${widget.phoneNumber}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  PinCodeTextField(
                    appContext: context,
                    length: 4,
                    onChanged: (value) {
                      // Handle onChanged event
                      if (value.length == 4) {
                        // Show confirmation message when OTP is entered
                        showConfirmationMessage();
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.circle,
                      inactiveFillColor: Colors.teal,
                      activeFillColor: Colors.teal.withOpacity(0.1),
                      selectedFillColor: Colors.teal.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<int>(
              valueListenable: timerNotifier,
              builder: (context, value, child) {
                return Text(
                  'Time remaining: ${value}s',
                  style: TextStyle(fontSize: 16),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed: () {
            // Add your OTP validation logic here
            // Example: if (isValidOTP) {
            timerNotifier.dispose(); // Stop the timer
            showConfirmationMessage(); // Show confirmation message
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RoleSelectionPage(),
              ),
            );
            // }
          },
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Continue'),
          style: ElevatedButton.styleFrom(
            primary: Colors.teal,
            onPrimary: Colors.white, // Set text color to white
            elevation: 10, // Add elevation for shadow effect
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            side: BorderSide(
              color: Colors.teal.withOpacity(0.3),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
