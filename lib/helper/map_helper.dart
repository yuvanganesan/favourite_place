import 'dart:convert';
import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = "";

class MapHelper {
  static String getMapPreviewImage(double latitude, double longitude) {
    return "https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v11/static/$longitude,$latitude,15,0/300x200?access_token=";
    //return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude=&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
  }

  static Future<String> getAddressDetails(double lat, double lng) async {
    // final url = Uri.parse(
    //     "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY");
    final url = Uri.parse(
        "https://api.mapbox.com/geocoding/v5/mapbox.places/$lng,$lat.json?types=place&language=en&access_token=");
    try {
      final response = await http.get(url);

      // return json.decode(response.body)["results"][0]["formatted_address"];
      return json.decode(response.body)['features'][0]['place_name'];
    } catch (error) {
      return "Currently can't fetch address";
    }
  }
}
//&signature=YOUR_SIGNATURE
//https://maps.googleapis.com/maps/api/geocode/json?latlng=9.737989799463366,77.79090609401464&key=
