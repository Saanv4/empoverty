import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../core/logger_utils.dart';

class DisplayPlacesAutoCompleteWidget extends StatelessWidget{
  TextEditingController controller = TextEditingController();
  final _logger = LoggerUtils();
  final _TAG = "DisplayPlacesAutoCompleteWidget";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
        boxDecoration: BoxDecoration(
            color: Colors.teal
        ),
        textEditingController: controller,
        googleAPIKey: 'AIzaSyBORWFlAagqPtr2Q58PbiQW1p1rxVMVJhw',
        inputDecoration: InputDecoration(
          hintText: "Search your location",
          hintStyle: TextStyle(
            color: Colors.white
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                width: 2,
                color: Colors.teal
            ),
          ),
        ),
        debounceTime: 1000,
        countries: ["in"],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          _logger.log(TAG: _TAG, message: "placeDetails clicked " + prediction.lat.toString());
          double latitude = double.parse(prediction.lat ?? "0");
          double longitude = double.parse(prediction.lng ?? "0");
          String locationName = prediction.description ?? '';

        },

        itemClick: (Prediction prediction) {
          //_logger.log(TAG: _TAG, message: "Inside item click ${prediction.lat} and long ${prediction.lng}");
          controller.text = prediction.description ?? "";
          controller.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description?.length ?? 0));
        },
        seperatedBuilder: Divider(
          color: Colors.white,
          thickness: 1,
        ),
        //containerHorizontalPadding: 10,
        // OPTIONAL// If you want to customize list view item builder
        itemBuilder: (BuildContext context, int index, Prediction prediction) {
          return Container(
            height: 50,
            color: Colors.teal,
            padding: const EdgeInsets.only(top: 4, bottom: 4),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 7,
                ),
                Expanded(
                    child: Text(
                      prediction.description ?? "",
                      style: const TextStyle(
                          color: Colors.white
                      ),
                    )
                )
              ],
            ),
          );
        },

        isCrossBtnShown: true,

        // default 600 ms ,
      ),
    );
  }

}