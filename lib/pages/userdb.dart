import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyUser {
  String id;
  final String name;
  final String emailAddress;
  final String phoneNumber;
  final String homeAddress;
  final List<dynamic> pastRequests;
  final List<dynamic> pendingRequests;
  final List<dynamic> acceptedupcomingRequests;

  MyUser({
    this.id = '',
    required this.name,
    required this.emailAddress,
    required this.phoneNumber,
    required this.homeAddress,
    required this.pastRequests,
    required this.pendingRequests,
    required this.acceptedupcomingRequests,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phoneNumber': phoneNumber,
    'homeAddress': homeAddress,
    'emailAddress': emailAddress,
    'pastRequests': pastRequests,
    'pendingRequests': pendingRequests,
    'acceptedupcomingRequests': acceptedupcomingRequests,
  };

  static MyUser fromJson(Map<String, dynamic> json) => MyUser(
    id: json['id'],
    name: json['name'],
    phoneNumber: json['phoneNumber'],
    homeAddress: json['homeAddress'],
    emailAddress: json['emailAddress'],
    pastRequests: json['pastRequests'],
    pendingRequests: json['pendingRequests'],
    acceptedupcomingRequests: json['acceptedupcomingRequests'],
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyUserForm(),
    );
  }
}

class MyUserForm extends StatefulWidget {
  @override
  _MyUserFormState createState() => _MyUserFormState();
}

class _MyUserFormState extends State<MyUserForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController homeAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyUser Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailAddressController,
              decoration: InputDecoration(labelText: 'Email Address'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: homeAddressController,
              decoration: InputDecoration(labelText: 'Home Address'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                saveMyUserData();
              },
              child: Text('Save MyUser Data'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveMyUserData() async {
    try {
      MyUser newUser = MyUser(
        name: nameController.text,
        emailAddress: emailAddressController.text,
        phoneNumber: phoneNumberController.text,
        homeAddress: homeAddressController.text,
        pastRequests: [],
        pendingRequests: [],
        acceptedupcomingRequests: [],
      );
      Map<String, dynamic> data = newUser.toJson();
      await FirebaseFirestore.instance.collection('users').add(data);

      print('MyUser data added to Firestore.');
    } catch (e) {
      print('Error adding MyUser data: $e');
    }
  }
}

void updateData(MyUser user) {
  final docUser = FirebaseFirestore.instance.collection('users').doc(user.id);
  docUser.update({'name': 'Emma'});
}
