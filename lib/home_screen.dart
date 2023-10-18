import 'package:flutter/material.dart';
import 'dart:async';
import 'package:project_googlemaps/screens/ar_map.dart';
import 'package:project_googlemaps/screens/current_location_screen.dart';
import 'package:project_googlemaps/screens/simple_map_screen.dart';
import 'package:project_googlemaps/screens/search_places_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Replace this with the URL or local path of your main image
  final String mainImageUrl = "assets/images/mapIcon2.png";

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AR map Tec", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          // Display the main image
          Expanded(
            child: Card(
              elevation: 4.0,
              margin: EdgeInsets.all(8.0),
              child: Image.asset(
                mainImageUrl, // Load the main image from your assets
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const SearchPlacesScreen();
                        },
                      ));
                    },
                    child: const Text("2D Map", style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const ARMap();
                        },
                      ));
                    },
                    child: const Text("AR Map", style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const CurrentLocationScreen();
                        },
                      ));
                    },
                    child: const Text("User Location", style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
