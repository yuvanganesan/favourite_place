import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../models/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, this.locData, this.isSelecting = false});

  final PlaceLocation? locData;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Map"),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: _pickedLocation == null
                    ? null
                    : () {
                        Navigator.of(context).pop(_pickedLocation);
                      },
                icon: const Icon(Icons.check))
        ],
      ),
      body: GoogleMap(
        /// mapType: MapType.satellite,
        markers: _pickedLocation == null && widget.isSelecting
            ? {}
            : {
                Marker(
                    markerId: const MarkerId("H"),
                    position: _pickedLocation ??
                        LatLng(widget.locData!.latitude,
                            widget.locData!.longitude))
              },
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.locData!.latitude, widget.locData!.longitude),
            zoom: 16),
        onTap: widget.isSelecting ? selectLocation : null,
      ),
    );
  }
}
