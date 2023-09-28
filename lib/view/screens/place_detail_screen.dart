import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/great_place.dart';
import './map_screen.dart';

class PlaceDetail extends StatelessWidget {
  const PlaceDetail({super.key});
  static const routeName = "/place-detail";

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)!.settings.arguments as String;
    final place =
        Provider.of<GreatPlace>(context, listen: false).getPlaceById(id);

    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            place.location.address!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey, fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.secondary),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      MapScreen(isSelecting: false, locData: place.location),
                ));
              },
              child: const Text("View Map", style: TextStyle(fontSize: 18)))
        ],
      ),
    );
  }
}
