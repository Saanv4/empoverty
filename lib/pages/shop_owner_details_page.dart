import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'newdashboardshopowner.dart';
import 'role_selection_page.dart';

class ShopOwnerDetailsPage extends StatefulWidget {
  @override
  _ShopOwnerDetailsPageState createState() => _ShopOwnerDetailsPageState();
}

class _ShopOwnerDetailsPageState extends State<ShopOwnerDetailsPage> {
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController yourNameController = TextEditingController();
  final TextEditingController shopLocationController = TextEditingController();
  String shopownerCategory = "Welding";

  GoogleMapController? mapController;
  final LatLng _initialCenter = const LatLng(37.7749, -122.4194);
  final Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return _showBackButtonWarning(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shop Owner Details'),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: shopNameController,
                decoration: InputDecoration(
                  labelText: 'Shop Name',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: yourNameController,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: shopLocationController,
                      decoration: InputDecoration(
                        labelText: 'Shop Location',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.location_on),
                    onPressed: () {
                      showMap();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: shopownerCategory,
                onChanged: (value) {
                  setState(() {
                    shopownerCategory = value!;
                  });
                },
                items: [
                  'Welding',
                  'Painting',
                  'Plumbing',
                ].map<DropdownMenuItem<String>>((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Row(
                      children: [
                        Icon(_getCategoryIcon(category)),
                        SizedBox(width: 8),
                        Text(category),
                      ],
                    ),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Shop Category',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_validateFields()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewDashboardShopOwner(userName: 'SAANVI'),
                      ),
                    );
                  }
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Welding':
        return Icons.build;
      case 'Painting':
        return Icons.color_lens;
      case 'Plumbing':
        return Icons.opacity;
      default:
        return Icons.category;
    }
  }

  void showMap() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 300,
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _initialCenter,
              zoom: 15.0,
            ),
            markers: _markers.values.toSet(),
          ),
        );
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      updateMarkers();
    });
  }

  void updateMarkers() {
    if (mapController != null) {
      final Marker marker = Marker(
        markerId: MarkerId('shop_location'),
        position: LatLng(37.7749, -122.4194),
        infoWindow: const InfoWindow(
          title: 'Shop Location',
          snippet: 'Your shop location',
        ),
      );

      setState(() {
        _markers['shop_location'] = marker;
      });

      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(37.7749, -122.4194),
            zoom: 15.0,
          ),
        ),
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RoleSelectionPage(),
        ),
      );
    }

    return confirmBack;
  }

  bool _validateFields() {
    if (shopNameController.text.isEmpty ||
        yourNameController.text.isEmpty ||
        shopLocationController.text.isEmpty) {
      setState(() {
        if (shopNameController.text.isEmpty) {
          shopNameController.clear();
          shopNameController.text = '';
        }
        if (yourNameController.text.isEmpty) {
          yourNameController.clear();
          yourNameController.text = '';
        }
        if (shopLocationController.text.isEmpty) {
          shopLocationController.clear();
          shopLocationController.text = '';
        }
      });
      return false;
    }
    return true;
  }
}

void main() {
  runApp(
    MaterialApp(
      home: ShopOwnerDetailsPage(),
    ),
  );
}
