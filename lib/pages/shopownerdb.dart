import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class ShopOwner {
  final String shopName;
  final String shopPhoneNumber;
  final String ShopOwnerName;
  final String shopLocation;
  final String gstNumber;
  final String shopCategory;
  final List<dynamic> shopownerRecommendations;

  ShopOwner({
    required this.shopName,
    required this.shopPhoneNumber,
    required this.ShopOwnerName,
    required this.shopLocation,
    required this.gstNumber,
    required this.shopCategory,
    required this.shopownerRecommendations,
  });

  Map<String, dynamic> toJson() => {
    'shopName': shopName,
    'shopPhoneNumber': shopPhoneNumber,
    'ownerName': ShopOwnerName,
    'shopLocation': shopLocation,
    'gstNumber': gstNumber,
    'shopCategory': shopCategory,
    'shopownerRecommendations': shopownerRecommendations,
  };

  static ShopOwner fromJson(Map<String, dynamic> json) => ShopOwner(
    shopName: json['shopName'],
    shopPhoneNumber: json['shopPhoneNumber'],
    ShopOwnerName: json['ShopOwnerName'],
    shopLocation: json['shopLocation'],
    gstNumber: json['gstNumber'],
    shopCategory: json['shopCategory'],
    shopownerRecommendations: json['shopownerRecommendations'],
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShopOwnerForm(),
    );
  }
}

class ShopOwnerForm extends StatefulWidget {
  @override
  _ShopOwnerFormState createState() => _ShopOwnerFormState();
}

class _ShopOwnerFormState extends State<ShopOwnerForm> {
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController shopPhoneNumberController = TextEditingController();
  final TextEditingController shopOwnerNameController = TextEditingController();
  final TextEditingController shopLocationController = TextEditingController();
  final TextEditingController gstNumberController = TextEditingController();
  final TextEditingController shopCategoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShopOwner Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: shopNameController,
              decoration: InputDecoration(labelText: 'Shop Name'),
            ),
            TextField(
              controller: shopPhoneNumberController,
              decoration: InputDecoration(labelText: 'Shop Phone Number'),
            ),
            TextField(
              controller: shopOwnerNameController,
              decoration: InputDecoration(labelText: 'Shop Owner Name'),
            ),
            TextField(
              controller: shopLocationController,
              decoration: InputDecoration(labelText: 'Shop Location'),
            ),
            TextField(
              controller: gstNumberController,
              decoration: InputDecoration(labelText: 'GST Number'),
            ),
            TextField(
              controller: shopCategoryController,
              decoration: InputDecoration(labelText: 'Shop Category'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                saveShopOwnerData();
              },
              child: Text('Save ShopOwner Data'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveShopOwnerData() async {
    try {
      ShopOwner newShopOwner = ShopOwner(
        shopName: shopNameController.text,
        shopPhoneNumber: shopPhoneNumberController.text,
        ShopOwnerName: shopOwnerNameController.text,
        shopLocation: shopLocationController.text,
        gstNumber: gstNumberController.text,
        shopCategory: shopCategoryController.text,
        shopownerRecommendations: [],
      );
      Map<String, dynamic> data = newShopOwner.toJson();
      await FirebaseFirestore.instance.collection('shopOwners').add(data);

      print('ShopOwner data added to Firestore.');
    } catch (e) {
      print('Error adding ShopOwner data: $e');
    }
  }
}
