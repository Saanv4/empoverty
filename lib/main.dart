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
import 'package:empoverty/routing%20/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDM7s2wKxnGjTwDA8kJKul3q_3etMCA5ME",
      authDomain: "empoverty.firebaseapp.com",
      projectId: "empoverty",
      storageBucket: "empoverty.appspot.com",
      messagingSenderId: "863346653780",
      appId: "1:863346653780:web:8f8db93a8b2843d6550bc1",
    ),
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget{

  AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "EmPoverty",
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(),
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
      builder: (BuildContext context, Widget? router){
        return router!;
      },
    );
  }

}


