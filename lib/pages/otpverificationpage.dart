import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homepage.dart';
import 'role_selection_page.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({Key? key, required this.phoneNumber, required this.verificationId})
      : super(key: key);

  final String phoneNumber;
  final String verificationId;

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  TextEditingController otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  void verifyOTP() async {
    String smsCode = otpController.text.trim();

    if (smsCode.length == 6) {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: smsCode,
      );

      try {
        UserCredential userCredential = await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          // Successful verification
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RoleSelectionPage(),
            ),
          );
        }
      } catch (e) {
        _showErrorMessage(context, 'Invalid OTP. Please try again.');
      }
    } else {
      _showErrorMessage(context, 'Please enter a valid OTP.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('One-Time Password Verification'),
        backgroundColor: Colors.teal,
        elevation: 5,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Enter the OTP sent to ${widget.phoneNumber}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter OTP',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: verifyOTP,
              child: Text('Verify OTP'),
            ),
          ],
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
