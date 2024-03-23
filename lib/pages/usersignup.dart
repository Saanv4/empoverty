import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class UserDataService {
  static Map<String, dynamic>? userData;

  static void setUserData(Map<String, dynamic> data) {
    userData = data;
  }

  static Map<String, dynamic>? getUserData() {
    return userData;
  }
}

class User {
  final String name;
  final String phone;
  final String address;

  User({
    required this.name,
    required this.phone,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'address': address,
  };

  static User fromJson(Map<String, dynamic> json) => User(
    name: json['name'],
    phone: json['phone'],
    address: json['address'],
  );
}

class Worker {
  final String workerName;
  final String workerField;
  final String workerPhoneNumber;
  final String workerEmail;
  final String workerLocation;
  final String workingHours;
  final List<dynamic> recommendationList;
  final List<dynamic> pendingRequests;
  final List<dynamic> acceptedUpcomingRequests;
  final List<dynamic> pastRequests;

  Worker({
    required this.workerName,
    required this.workerField,
    required this.workerPhoneNumber,
    required this.workerEmail,
    required this.workerLocation,
    required this.workingHours,
    required this.pendingRequests,
    required this.acceptedUpcomingRequests,
    required this.pastRequests,
    required this.recommendationList,
  });

  Map<String, dynamic> toJson() => {
    'workerName': workerName,
    'workerField': workerField,
    'workerPhoneNumber': workerPhoneNumber,
    'workerEmail': workerEmail,
    'workerLocation': workerLocation,
    'workingHours': workingHours,
    'pendingRequests': pendingRequests,
    'recommendationList': recommendationList,
    'acceptedUpcomingRequests': acceptedUpcomingRequests,
    'pastRequests': pastRequests,
  };

  static Worker fromJson(Map<String, dynamic> json) => Worker(
    recommendationList: json['recommendationList'],
    workerName: json['workerName'],
    workerField: json['workerField'],
    workerPhoneNumber: json['workerPhoneNumber'],
    workerEmail: json['workerEmail'],
    workerLocation: json['workerLocation'],
    workingHours: json['workingHours'],
    pendingRequests: json['pendingRequests'],
    acceptedUpcomingRequests: json['acceptedUpcomingRequests'],
    pastRequests: json['pastRequests'],
  );
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserPage(),
    );
  }
}

class UserPage extends StatelessWidget {
  const UserPage({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Phone #',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  hintText: 'Enter your phone number',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Home Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  hintText: 'Enter your home address',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String name = nameController.text;
                String phone = phoneController.text;
                String address = addressController.text;

                if (name.isNotEmpty && phone.isNotEmpty && address.isNotEmpty) {
                  try {
                    await FirebaseFirestore.instance.collection('UserData').add({
                      'name': name,
                      'phone': phone,
                      'address': address,
                    });

                    UserDataService.setUserData({
                      'name': name,
                      'phone': phone,
                      'address': address,
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserDashboard()),
                    );
                  } catch (exception) {
                    print("Error saving data to Firestore: $exception");
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Validation Error'),
                        content: Text('Please fill in all fields.'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

class UserDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfilePage()),
            );
          },
          icon: Icon(Icons.edit),
          label: Text('Edit User Profile'),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'Dashboard Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Edit User Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Help'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Map<String, dynamic>? userData = UserDataService.getUserData();
    if (userData != null) {
      nameController.text = userData['name'];
      phoneController.text = userData['phone'];
      addressController.text = userData['address'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDashboard(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Phone #',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                hintText: 'Enter your phone number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Home Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                hintText: 'Enter your home address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String name = nameController.text;
                String phone = phoneController.text;
                String address = addressController.text;

                if (name.isNotEmpty && phone.isNotEmpty && address.isNotEmpty) {
                  try {
                    await FirebaseFirestore.instance
                        .collection('UserData')
                        .doc('latestData')
                        .set({
                      'name': name,
                      'phone': phone,
                      'address': address,
                    });

                    UserDataService.setUserData({
                      'name': name,
                      'phone': phone,
                      'address': address,
                    });

                    Navigator.pop(context);
                  } catch (exception) {
                    print("Error saving data to Firestore: $exception");
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Validation Error'),
                        content: Text('Please fill in all fields.'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Save Edit'),
            ),
          ],
        ),
      ),
    );
  }
}


