import 'package:flutter/material.dart';
import 'user_sidebar.dart';
import 'role_button.dart';
import 'shop_owner_details_page.dart';
import 'dashboard_page_user.dart';
import 'usersignup.dart';
import 'usersignup.dart';
import 'newdashboardshopowner.dart';
import 'workersignup.dart';
class RoleSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Role'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: NeumorphicRoleButton(
                role: 'Shop Owner',
                icon: Icons.store,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopOwnerDetailsPage(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: NeumorphicRoleButton(
                role: 'User',
                icon: Icons.person,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsPage(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: NeumorphicRoleButton(
                role: 'Worker',
                icon: Icons.work,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkerSignupPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NeumorphicRoleButton extends StatelessWidget {
  final String role;
  final IconData icon;
  final VoidCallback? onPressed;

  NeumorphicRoleButton({
    required this.role,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(1, 1),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.7),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(-1, -1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 36,
              color: Colors.teal,
            ),
            SizedBox(height: 8),
            Text(
              role,
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
