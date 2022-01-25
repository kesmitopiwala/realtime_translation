import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

///Initialization of avilable cameras list
List<CameraDescription> cameras = [];

class RealtimeTranslation {

  ///Get list of available cameras
  Future<void> cameraInitialization() async{
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  }
}
