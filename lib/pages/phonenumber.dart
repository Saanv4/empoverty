import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'otpverificationpage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirstRoute extends StatefulWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  TextEditingController phoneNumberController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance; // Added to create an instance of FirebaseAuth


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal, Colors.teal.shade300],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/images/empoverty.png', // Adjust the path according to your file location
                  height: 100, // Adjust the height as needed
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 300,
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        child: Text(
                          '+91',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          maxLength: 10,
                          controller: phoneNumberController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Enter Phone Number',
                            labelStyle: TextStyle(fontSize: 14, color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Colors.white.withOpacity(0.9); // Color when hovered
                    }
                    return Colors.white.withOpacity(0.7); // Default color
                  }),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () {
                  String phoneNumber = "+91" + phoneNumberController.text;

                  // Validate the phone number
                  if (phoneNumberController.text.length == 10) {
                    print('Starting phone number verification for: $phoneNumber at ${DateTime.now()}');
                    _auth.verifyPhoneNumber(
                      phoneNumber: phoneNumber,
                      verificationCompleted: (PhoneAuthCredential credential) {
                        print('Verification completed: ${credential.smsCode} at ${DateTime.now()}');
                        // Automatic handling of the code verification
                      },
                      verificationFailed: (FirebaseAuthException e) {
                        print('Verification failed at ${DateTime.now()}');
                        print('Error code: ${e.code}');
                        print('Error message: ${e.message}');
                        _showErrorMessage(context, 'Verification failed: ${e.message}');
                      },
                      codeSent: (String verificationId, int? resendToken) {
                        print('Code sent to $phoneNumber at ${DateTime.now()} with verificationId: $verificationId');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OTPVerificationPage(
                              phoneNumber: phoneNumber,
                              verificationId: verificationId,
                            ),
                          ),
                        );
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {
                        print('Auto-retrieval timeout for verificationId: $verificationId at ${DateTime.now()}');
                      },
                    );
                  } else {
                    _showErrorMessage(context, 'Invalid phone number. Please enter 10 digits.');
                  }
                },
                child: Container(
                  width: 150,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    'Verify',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
