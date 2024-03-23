import 'package:flutter/material.dart';

class RoleButton extends StatelessWidget {
  final String role;
  final IconData icon;
  final VoidCallback? onPressed;

  const RoleButton(
      {Key? key, required this.role, required this.icon, this.onPressed, required Null Function() onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(
            height: 2,
            width: 2,
          ),
          Text(role),
        ],
      ),
    );
  }
}
