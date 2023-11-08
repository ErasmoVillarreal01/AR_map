import 'package:flutter/material.dart';
import 'dart:async';
import 'package:project_googlemaps/screens/ar_map.dart';
import 'package:project_googlemaps/unused%20screens/current_location_screen.dart';
import 'package:project_googlemaps/unused%20screens/simple_map_screen.dart';
import 'package:project_googlemaps/screens/search_places_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Replace this with the URL or local path of your main image
  int _imageIndex = 0;
  final List<String> _imageUrls = [
    "assets/images/rectoria.jpg",
    "assets/images/cerro.jpg",
    "assets/images/biblio.jpg",
    // Add as many image paths as you have for the slideshow
  ];

  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      setState(() {
        _imageIndex = (_imageIndex + 1) % _imageUrls.length; // Cycle through the list
      });
    });


  }

  @override

  void dispose() {
    _timer.cancel(); // Always cancel your timer to prevent memory leaks
    super.dispose();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tec Map", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(top: 8.0),
                child:
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const SearchPlacesScreen(flag: 1,);
                        },
                      ));
                    },
                    child: const Text("Rectoria", style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue),
                      minimumSize: MaterialStateProperty.all(Size(150, 50)),
                      ),
                  ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.0),
                child:
                  ElevatedButton(
                  onPressed: () {

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const SearchPlacesScreen(flag: 2,);
                      },
                    ));
                  },
                  child: const Text("BiblioTec", style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                    minimumSize: MaterialStateProperty.all(Size(150, 50)),
                      ),
                  ),
              ),

          ],
      ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8.0),
                    child:
                    ElevatedButton(
                      onPressed: () {

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const SearchPlacesScreen(flag: 3,);
                          },
                        ));
                      },
                      child: const Text("Jubileo", style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        minimumSize: MaterialStateProperty.all(Size(150, 50)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.0),
                    child:
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return  SearchPlacesScreen(flag: 4,);
                          },
                        ));
                      },
                      child: const Text("Centrales", style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        minimumSize: MaterialStateProperty.all(Size(150, 50)),
                      ),
                    ),
                  ),




            ],
          ),
          Expanded(
            child: Card(
              elevation: 4.0,
              margin: EdgeInsets.all(8.0),
              child: Image.asset(
                _imageUrls[_imageIndex], // Load the image from the list based on the current index
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
                          return const SearchPlacesScreen(flag: 0,);
                        },
                      ));
                    },
                    // Use a Row widget to lay out the icon and text horizontally
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Use MainAxisSize.min to ensure the row doesn't stretch
                      children: [
                        Icon(Icons.map, color: Colors.white), // Change the icon to whatever you prefer
                        SizedBox(width: 8), // Add space between the icon and the text
                        Text("2D Map", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      minimumSize: MaterialStateProperty.all(Size(150, 60)),
                      // Adjust padding as needed, depending on the space the icon and text take up
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 16)),
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
                    // Use a Row widget to lay out the icon and text horizontally
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Use min to prevent the Row from taking more space than its content
                      children: [
                        Icon(Icons.camera, color: Colors.white), // Camera icon with white color
                        SizedBox(width: 8), // Provide some space between the icon and the text
                        Text("AR Map", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      minimumSize: MaterialStateProperty.all(Size(150, 60)),
                      // Padding can be adjusted if needed to center the content
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 16)),
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
