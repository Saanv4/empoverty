import 'package:flutter/material.dart';

class MyStyledButton extends StatelessWidget {
  final String buttonText;
  final Widget pageWidget;
  final Color backgroundColor;
  final Color textColor;
  final double width;
  final double borderRadius;
  final MaterialColor borderColor;

  const MyStyledButton({
    required this.buttonText,
    required this.pageWidget,
    required this.backgroundColor,
    required this.textColor,
    this.width = 250.0,
    this.borderRadius = 16.0,
    required this.borderColor, required Null Function() onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.transparent, backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        side: BorderSide(
          color: Colors.teal.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withOpacity(0.2),
              offset: Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.7),
              offset: Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'ModernFont',
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
