import 'package:flutter/material.dart';
import '../widgets/image_input.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../../providers/great_place.dart';
import '../widgets/location_input.dart';
import '../../models/place.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});
  static var routeName = "/addPlaceScreen";

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleControler = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  void _saveImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _saveLocation(PlaceLocation? pickedLocation) {
    _pickedLocation = pickedLocation;
  }

  void _addPlace() {
    if (_pickedImage == null ||
        _titleControler.text.isEmpty ||
        _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlace>(context, listen: false)
        .addPlace(_titleControler.text, _pickedImage!, _pickedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add Place"),
      ),
      // MediaQuery.of(context).size.height -4.1.0
      //1.4.20
      //         AppBar().preferredSize.height -
      //         MediaQuery.of(context).padding.top,
      body: Column(
          //mainAxisAlignment: MainAxisAlignment.,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(label: Text("Title")),
                      controller: _titleControler,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ImageInput(
                      saveImage: _saveImage,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    LocationInput(saveLocation: _saveLocation)
                  ],
                ),
              ),
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 0,
                    backgroundColor: Theme.of(context).colorScheme.secondary),
                onPressed: _addPlace,
                icon: const Icon(Icons.add),
                label: const Text("Add Place"))
          ]),
    );
  }
}
