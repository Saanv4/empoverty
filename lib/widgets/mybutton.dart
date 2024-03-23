import 'package:flutter/material.dart';

import '../pages/phonenumber.dart';

class MyButton extends StatefulWidget {
  const MyButton({
    Key? key,
    required this.buttonText,
    required this.pageWidget,
    required Null Function() onPressed,
  }) : super(key: key);

  final String buttonText;
  final Widget pageWidget;

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget.pageWidget),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(300, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: Color.fromARGB(1, 217, 217, 217),
      ),
      child: Text(
        widget.buttonText,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
