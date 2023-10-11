import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SimpleMapsScreen extends StatefulWidget {
  const SimpleMapsScreen({super.key});

  @override
  State<SimpleMapsScreen> createState() => _SimpleMapsScreenState();
}

class _SimpleMapsScreenState extends State<SimpleMapsScreen> {

  final Completer<GoogleMapController> _controller = Completer();


  static const  CameraPosition initialPosition = CameraPosition(target: LatLng(26.6516, - 101.2895), zoom: 14.0);
  static const  CameraPosition targetPosition = CameraPosition(target: LatLng(25.6516, -100.2895), zoom: 16.0);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Maps", style: TextStyle(color: Colors.white)), centerTitle: true,backgroundColor: Colors.blue),
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.all(16.0),
          width: 130.0,
          height: 40.0,// Adjust the margin as needed
          child: FloatingActionButton(
            onPressed: () {
              goToTEC();
            },
            child: Text("Go to the Campus"),
          ),
        ),
      ),
    );
  }


  Future<void> goToTEC() async{
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(targetPosition));
  }
}
