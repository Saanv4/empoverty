import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../main.dart';

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


class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _showBackButtonWarning(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
              child: Image.asset(
                'assets/images/empoverty.png',
                width: 200, // Adjust width as needed
                height: 200, // Adjust height as needed
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Enter your name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        contentPadding: EdgeInsets.all(12.0),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        labelText: 'Enter your phone number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        contentPadding: EdgeInsets.all(12.0),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                        labelText: 'Enter your home address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        contentPadding: EdgeInsets.all(12.0),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        // Add onPressed functionality
                      },
                      child: Text('Continue'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBackButtonWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Warning"),
          content: Text("Are you sure you want to go back?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}


  Future<bool> _showBackButtonWarning(BuildContext context) async {
    bool confirmBack = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text('Data will not be saved. Are you sure you want to go back?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Yes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    ) ?? false;

    if (confirmBack) {
      Navigator.of(context).pop(); // Pop the current screen if the user confirms back
    }

    return confirmBack;
  }

