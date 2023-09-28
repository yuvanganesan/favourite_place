import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './view/screens/place_list_screen.dart';
import './view/screens/add_place_screen.dart';
import './providers/great_place.dart';
import './view/screens/place_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlace(),
      child: MaterialApp(
        title: 'Favourite Places',
        theme: ThemeData(
          // appBarTheme: const AppBarTheme(
          //     color: Colors.lightGreen,
          //     titleTextStyle: TextStyle(color: Colors.white)),
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.lightGreen, secondary: Color(0xff698834)),
          //colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          //useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const PlaceListScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => const AddPlaceScreen(),
          PlaceDetail.routeName: (context) => const PlaceDetail()
        },
      ),
    );
  }
}
