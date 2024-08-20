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

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Use the Firebase Auth emulator in development mode
  if (kDebugMode) {
    // FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

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
