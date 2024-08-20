import 'package:empoverty/pages/homepage.dart';
import 'package:empoverty/pages/homepage.dart';
import 'package:empoverty/pages/newdashboardshopowner.dart';
import 'package:empoverty/pages/newdashboarduser.dart';
import 'package:empoverty/pages/usersignup.dart';
import 'package:empoverty/pages/role_selection_page.dart';
import 'package:empoverty/pages/shop_owner_details_page.dart';
import 'package:empoverty/pages/usersignup.dart';
import 'package:empoverty/pages/workerdb.dart';
import 'package:empoverty/pages/workersignup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import the generated file
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Automatically selects the correct platform options
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EmPoverty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    );
  }
}
