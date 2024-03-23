import 'package:flutter/material.dart';

class EditUserProfilePage extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: userNameController,
              decoration: const InputDecoration(labelText: 'User Name'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone #'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Home Address'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
