import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'homepage.dart';

class NewDashboardShopOwner extends StatefulWidget {
  final String userName;

  NewDashboardShopOwner({required this.userName});

  @override
  _NewDashboardShopOwnerState createState() => _NewDashboardShopOwnerState();
}

class _NewDashboardShopOwnerState extends State<NewDashboardShopOwner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Owner Dashboard'),
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
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                  ModalRoute.withName('/'),
                );
              },
            ),
            ListTile(
              title: Text('Help'),
              onTap: () {
                _showHelpPopup(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, ${widget.userName}, to your Shop Owner Dashboard!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showRecommendationInputPopup(context);
              },
              child: Icon(Icons.add),
            ),
            SizedBox(height: 20),
            RecommendationList(),
          ],
        ),
      ),
    );
  }

  void _showRecommendationInputPopup(BuildContext context) {
    TextEditingController workerNameController = TextEditingController();
    TextEditingController workerPhoneNumberController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Recommendation Input'),
          content: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: workerNameController,
                  decoration: InputDecoration(labelText: 'Worker Name'),
                ),
                TextFormField(
                  controller: workerPhoneNumberController,
                  decoration: InputDecoration(labelText: 'Worker Phone Number'),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (workerNameController.text.isNotEmpty &&
                    workerPhoneNumberController.text.isNotEmpty) {
                  _saveRecommendationData(
                    workerNameController.text,
                    workerPhoneNumberController.text,
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill out all details.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showHelpPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Help'),
          content: Text('Contact 123456789'),
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

  void _saveRecommendationData(String workerName, String workerPhoneNumber) {
    FirebaseFirestore.instance.collection('Recommendations').add({
      'workerName': workerName,
      'workerPhoneNumber': workerPhoneNumber,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _shopNameController;
  late TextEditingController _yourNameController;
  late TextEditingController _shopLocationController;
  late TextEditingController _gstNumberController;
  late TextEditingController _shopCategoryController;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _shopNameController = TextEditingController();
    _yourNameController = TextEditingController();
    _shopLocationController = TextEditingController();
    _gstNumberController = TextEditingController();
    _shopCategoryController = TextEditingController();

    _fetchProfileData();
  }

  void _fetchProfileData() async {
    DocumentSnapshot snapshot =
    await FirebaseFirestore.instance.collection('ShopOwnerData').doc('latestData').get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        _shopNameController.text = data['shopName'] ?? '';
        _yourNameController.text = data['yourName'] ?? '';
        _shopLocationController.text = data['shopLocation'] ?? '';
        _gstNumberController.text = data['gstNumber'] ?? '';
        _shopCategoryController.text = data['shopCategory'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEditableField('Shop Name', _shopNameController),
            _buildEditableField('Your Name', _yourNameController),
            _buildEditableField('Shop Location', _shopLocationController),
            _buildEditableField('GST Number', _gstNumberController),
            _buildEditableField('Shop Category', _shopCategoryController),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (isEditing) {
                        _saveEditedData();
                      }
                      isEditing = !isEditing;
                    });
                  },
                  child: Text(isEditing ? 'Save' : 'Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label:'),
        isEditing
            ? TextFormField(
          controller: controller,
        )
            : Text(controller.text),
        SizedBox(height: 10),
      ],
    );
  }

  void _saveEditedData() {
    FirebaseFirestore.instance.collection('ShopOwnerData').doc('latestData').update({
      'shopName': _shopNameController.text,
      'yourName': _yourNameController.text,
      'shopLocation': _shopLocationController.text,
      'gstNumber': _gstNumberController.text,
      'shopCategory': _shopCategoryController.text,
    });
  }
}


class RecommendationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Recommendations').orderBy('timestamp', descending: true).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No recommendations available');
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return RecommendationCard(
              workerName: data['workerName'] ?? '',
              workerPhoneNumber: data['workerPhoneNumber'] ?? '',
              documentId: document.id,
            );
          }).toList(),
        );
      },
    );
  }
}

class RecommendationCard extends StatefulWidget {
  final String workerName;
  final String workerPhoneNumber;
  final String documentId;

  RecommendationCard({
    required this.workerName,
    required this.workerPhoneNumber,
    required this.documentId,
  });

  @override
  _RecommendationCardState createState() => _RecommendationCardState();
}

class _RecommendationCardState extends State<RecommendationCard> {
  late TextEditingController _editedNameController;
  late TextEditingController _editedPhoneNumberController;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _editedNameController = TextEditingController(text: widget.workerName);
    _editedPhoneNumberController = TextEditingController(text: widget.workerPhoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ExpansionTile(
        title: isEditing
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Worker Name:'),
            TextFormField(
              controller: _editedNameController,
            ),
          ],
        )
            : Text('Worker Name: ${widget.workerName}'),
        subtitle: isEditing
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Phone Number:'),
            TextFormField(
              controller: _editedPhoneNumberController,
              keyboardType: TextInputType.phone,
            ),
          ],
        )
            : Text('Phone Number: ${widget.workerPhoneNumber}'),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(isEditing ? Icons.save : Icons.edit),
                onPressed: () {
                  setState(() {
                    if (isEditing) {
                      _saveEditedData();
                    }
                    isEditing = !isEditing;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: _deleteRecommendation,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _deleteRecommendation() {
    FirebaseFirestore.instance.collection('Recommendations').doc(widget.documentId).delete();
  }

  void _saveEditedData() {
    FirebaseFirestore.instance.collection('Recommendations').doc(widget.documentId).update({
      'workerName': _editedNameController.text,
      'workerPhoneNumber': _editedPhoneNumberController.text,
    });
  }
}

class EditRecommendationPage extends StatelessWidget {
  final String documentId;

  EditRecommendationPage({required this.documentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Recommendation'),
      ),
      body: Center(
        child: Text('Editing Recommendation with ID: $documentId'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NewDashboardShopOwner(userName: ''),
  ));
}
