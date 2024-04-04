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

    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
          (Timer timer) {
        if (timerSeconds == 0) {
          timer.cancel();
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
        backgroundColor: Colors.green,
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

        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/empoverty.png',

            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Text(
                      'Kindly enter OTP to verify for ${widget.phoneNumber}',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    /*PinCodeTextFormField(
                      appContext: context,
                      length: 4,
                      onChanged: (value) {

                        if (value.length == 4) {

                          showConfirmationMessage();
                        }
                      },
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.circle,
                        inactiveFillColor: Colors.teal,
                        activeFillColor: Colors.teal.withOpacity(0.1),
                        selectedFillColor: Colors.teal.withOpacity(0.1),
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<int>(
              valueListenable: timerNotifier,
              builder: (BuildContext context, int value, Widget? child) {
                if (value > 5) {
                  return Text(
                    'Time remaining: ${value}s',
                    style: TextStyle(fontSize: 16),
                  );
                } else {
                  return TextButton(
                    onPressed: () {},
                    child: Text(
                      'Resend OTP',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed: () {
            timerNotifier.dispose();
            showConfirmationMessage();
            Navigator.pushReplacement(
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
            foregroundColor: Colors.white, backgroundColor: Colors.teal,
            elevation: 10,
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
