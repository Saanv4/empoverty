import 'package:empoverty/widgets/displayplacesautocompletewidget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DisplayMapsPage extends StatelessWidget{
  // init the position using the user location

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.630813, 77.216463),
    zoom: 15,
  );
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Location"),
      ),
      body: Stack(
        children: [
          Positioned.fill(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {

                },
                markers: {
                  Marker(
                    markerId: const MarkerId("marker1"),
                    position: const LatLng(28.630813, 77.216463),
                    draggable: true,
                    onDragEnd: (value) {
                      // value is the new position
                    },
                    icon: markerIcon,
                  ),
                },
              )
          ),
          Positioned(
              top: 50,
              child: DisplayPlacesAutoCompleteWidget()
          ),

        ],
      ),
    );
  }

}