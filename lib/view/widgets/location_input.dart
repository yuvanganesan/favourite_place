import 'package:favourite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../helper/map_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, this.saveLocation});
  final Function? saveLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _locationUrl;

  void _userCurrentLocation() {
    Location().getLocation().then((locData) {
      _getAndSetPreviewUrl(locData.latitude!, locData.longitude!);
    });
  }

  void _getAndSetPreviewUrl(double latitude, double longitude) {
    try {
      widget.saveLocation!(PlaceLocation(
        latitude: latitude,
        longitude: longitude,
      ));
      final previewUrl = MapHelper.getMapPreviewImage(latitude, longitude);
      setState(() {
        _locationUrl = previewUrl;
      });
    } catch (error) {
      return;
    }
  }

  Future<void> _openSelectOnMapScreen() async {
    final locData = await Location().getLocation();
    final selectedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      builder: (context) => MapScreen(
          locData: PlaceLocation(
            latitude: locData.latitude!,
            longitude: locData.longitude!,
          ),
          isSelecting: true),
    ));
    if (selectedLocation == null) {
      return;
    }
    _getAndSetPreviewUrl(selectedLocation.latitude, selectedLocation.longitude);
    print("${selectedLocation.latitude}\n${selectedLocation.longitude}");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 200,
          width: double.infinity,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
          child: _locationUrl == null
              ? const Text("No location selected")
              : Image.network(
                  _locationUrl!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.secondary),
                onPressed: _userCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: const Text("Cuttent location")),
            const SizedBox(
              width: 20,
            ),
            TextButton.icon(
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.secondary),
                onPressed: _openSelectOnMapScreen,
                icon: const Icon(Icons.map),
                label: const Text("Select on map")),
          ],
        )
      ],
    );
  }
}
