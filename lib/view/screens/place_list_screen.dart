import './add_place_screen.dart';
import 'package:flutter/material.dart';
import '../../providers/great_place.dart';
import 'package:provider/provider.dart';
import './place_detail_screen.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place List"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<GreatPlace>(context, listen: false).fetchAndSetPlace(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlace>(
                child: const Center(child: Text("Oops there is no places..")),
                builder: (context, value, ch) => value.places.isEmpty
                    ? ch!
                    : ListView.builder(
                        itemBuilder: (context, index) => Card(
                          //margin: EdgeInsets.symmetric(vertical: ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(value.places[index].image)),
                              title: Text(value.places[index].title),
                              subtitle:
                                  Text(value.places[index].location.address!),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    PlaceDetail.routeName,
                                    arguments: value.places[index].id);
                              },
                            ),
                          ),
                        ),
                        itemCount: value.places.length,
                      ),
              ),
      ),
    );
  }
}
