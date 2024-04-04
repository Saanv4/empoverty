import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController shopNameController = TextEditingController();
  TextEditingController yourNameController = TextEditingController();
  TextEditingController shopLocationController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  String selectedShopCategory = "Welding"; // Default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User Profile'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('ShopOwnerData').doc('latestData').snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.data() == null) {
            return Text('No data available');
          }

          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          shopNameController.text = data['shopName'];
          yourNameController.text = data['yourName'];
          shopLocationController.text = data['shopLocation'];
          gstNumberController.text = data['gstNumber'];
          selectedShopCategory = data['shopCategory'];

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shop Name'),
                TextFormField(
                  controller: shopNameController,
                ),
                SizedBox(height: 16),
                Text('Your Name'),
                TextFormField(
                  controller: yourNameController,
                ),
                SizedBox(height: 16),
                Text('Shop Location'),
                TextFormField(
                  controller: shopLocationController,
                ),
                SizedBox(height: 16),
                Text('GST Number'),
                TextFormField(
                  controller: gstNumberController,
                ),
                SizedBox(height: 16),
                Text('Shop Category'),
                DropdownButton<String>(
                  value: selectedShopCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedShopCategory = newValue!;
                    });
                  },
                  items: <String>['Welding', 'Painting', 'Plumbing']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _updateProfileData();
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _updateProfileData() async {
    try {
      await FirebaseFirestore.instance.collection('ShopOwnerData').doc('latestData').update({
        'shopName': shopNameController.text,
        'yourName': yourNameController.text,
        'shopLocation': shopLocationController.text,
        'gstNumber': gstNumberController.text,
        'shopCategory': selectedShopCategory,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully!'),
        ),
      );
    } catch (error) {
      print('Error updating profile: $error');
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: EditProfilePage(),
    ),
  );
}

