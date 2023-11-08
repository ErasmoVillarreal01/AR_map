import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

class SearchPlacesScreen extends StatefulWidget {
  final int flag;

  const SearchPlacesScreen({Key? key, required this.flag}) : super(key: key);

  @override
  _SearchPlacesScreenState createState() => _SearchPlacesScreenState();


}

const kGoogleApiKey = 'AIzaSyBmQLQbgUi0CTa0xarGXLzuiNdyTDdAMNQ';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
  static late CameraPosition initialCameraPosition;
  Set<Marker> markers = {};

  late GoogleMapController googleMapController;

  final Mode _mode = Mode.overlay;


  @override
  void initState() {
    super.initState();
    initialCameraPosition = _getInitialCameraPosition(widget.flag);
  }

  CameraPosition _getInitialCameraPosition(int flag) {
    switch (flag) {
      case 1:
        return CameraPosition(target: LatLng(25.651517400942506, -100.29102206361668), zoom: 19.0); // Example for "Rectoria"
      case 2:
        return CameraPosition(target: LatLng(25.65044623913068, -100.28972434952794), zoom: 19.0); // Example for "BiblioTec"
      case 3:
        return CameraPosition(target: LatLng(25.648830082071093, -100.29002662830163), zoom: 19.0); // Example for "Jubileo"
      case 4:
        return CameraPosition(target: LatLng(25.6515, -100.2890), zoom: 19.0); // Example for "Centrales"
      default:
        return CameraPosition(target: LatLng(25.651228904715932, -100.28748688696668), zoom: 19.0); // Default position
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: const Text("Google Search Places", style: TextStyle(color: Colors.white,)),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: markers,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),
          Container(
            margin: const EdgeInsets.all(8.0), // Use EdgeInsets to specify the amount of margin
            child: ElevatedButton(
              onPressed: _handlePressButton, child: const Text("Search Places", style: TextStyle(color: Colors.white),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
            )
          )




        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await _determinePosition();

          googleMapController
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14)));


          markers.clear();

          markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(position.latitude, position.longitude)));

          setState(() {});

        },
        label: const Text("Current Location", style: TextStyle(color: Colors.white,),),
        icon: const Icon(Icons.location_history,  color: Colors.white,),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white))),
        components: [Component(Component.country,"pk"),Component(Component.country,"usa"), Component(Component.country,"mex")]);


    displayPrediction(p!,homeScaffoldKey.currentState);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);

    return position;
  }

  void onError(PlacesAutocompleteResponse response){

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: response.errorMessage!,
        contentType: ContentType.failure,
      ),
    ));

    // homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> displayPrediction(Prediction p, ScaffoldState? currentState) async {

    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders()
    );

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    markers.clear();
    markers.add(Marker(markerId: const MarkerId("0"),position: LatLng(lat, lng),infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {});

    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));

  }
}