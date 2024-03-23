import 'package:flutter/material.dart';
import '../pages/otpverificationpage.dart';

class PhoneNumberDialog extends StatelessWidget {
  const PhoneNumberDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _phoneNumberController = TextEditingController();

    return AlertDialog(
      title: Text('Enter Phone Number'),
      content: TextField(
        controller: _phoneNumberController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: 'Enter phone number',
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Perform action with the entered phone number
            String phoneNumber = _phoneNumberController.text;
            print('Entered phone number: $phoneNumber');

            Navigator.of(context).pop();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    OTPVerificationPage(phoneNumber: phoneNumber),
              ),
            );
          },
          child: Text('Submit'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
