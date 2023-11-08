import 'package:camera/camera.dart ';
import 'package:flutter/material.dart';

class ARMap extends StatefulWidget {
  const ARMap({super.key});

  @override
  State<ARMap> createState() => _ARMapState();
}

class _ARMapState extends State<ARMap> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  @override
  void initState() {
    // TODO: implement initState
    startCamera();
    super.initState();
  }

  void startCamera() async{
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
    );
    await cameraController.initialize().then((value){
      if(!mounted){
        return;
      }
      setState(() {});
    }).catchError((e){
      print(e);
    });
  }
  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(title: Text("AR Map", style: TextStyle(color: Colors.white)), centerTitle: true, backgroundColor: Colors.blue),
        body: Center(
          child: CameraPreview(cameraController),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

}

