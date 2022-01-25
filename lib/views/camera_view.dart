import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:translator/translator.dart';

import '../realtime_translation.dart';

///Callback of get detected text
typedef GetDetectedText = void Function(String detectGetText);

///Callback of get translated text
typedef GetTranslatedText = void Function(String translatGetText);

///TsCameraView where detect text and manage zooming level of camera
class TsCameraView extends StatefulWidget {
  TsCameraView(
      {Key? key,
      required this.onGetDetectedText,
      required this.onGetTranslatedText,
      required this.languageCode,
      this.initialDirection = CameraLensDirection.back})
      : super(key: key);

  ///TsCamera direction
  CameraLensDirection initialDirection;

  ///Get callback of detected text
  GetDetectedText onGetDetectedText;

  ///Get callback of translated text
  GetTranslatedText onGetTranslatedText;

  ///Get select language code
  String languageCode;

  @override
  _TsCameraViewState createState() => _TsCameraViewState();
}

class _TsCameraViewState extends State<TsCameraView> {

  ///For controls camera device
  CameraController? _controller;

  ///Default select camera index
  int _cameraIndex = 0;

  ///Default camera zoom level,minimum zoom level and maximum zoom level
  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;

  ///Check camera is busy
  bool isBusy = false;

  ///Temporary value of translated text
  var temp;

  ///Used for translation of detected text
  GoogleTranslator translator = GoogleTranslator();

  ///Used for text detected through the gogole ml kit
  TextDetector textDetector = GoogleMlKit.vision.textDetector();

  ///Get translated text
  String translatedText = '';

  @override
  void initState() {
    super.initState();
    ///For camera conmtroller initialization,get camera minimum and maximum zoom level and get live image stream data
    _startLiveFeed();
  }

  @override
  void dispose() {
    ///Make camera controller and stop camera for get image stream
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///TsCameraview for detect text with used of google ml kit
    return Scaffold(
      body: _body(),
    );
  }

  ///TsCameraview for detect text with used of google ml kit
  Widget _body() {
    Widget body = _liveFeedBody();
    return body;
  }

  Widget _liveFeedBody() {
    ///If camera controller is not initialized than return empty container
    if (_controller?.value.isInitialized == false) {
      return Container();
    }
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ///Camera preview widget for the given camera controller
          CameraPreview(_controller!),
          ///Slider for manage zoomin level of camera
          Positioned(
            top: 100,
            left: 50,
            right: 50,
            child: Slider(
              value: zoomLevel,
              min: minZoomLevel,
              max: maxZoomLevel,
              onChanged: (newSliderValue) {
                setState(() {
                  zoomLevel = newSliderValue;
                  _controller!.setZoomLevel(zoomLevel);
                });
              },
              divisions: (maxZoomLevel - 1).toInt() < 1
                  ? null
                  : (maxZoomLevel - 1).toInt(),
            ),
          )
        ],
      ),
    );
  }

  ///For camera conmtroller initialization,get camera minimum and maximum zoom level and get live image stream data
  Future _startLiveFeed() async {

    ///Camera controller initialization
    final camera = cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.low,
      enableAudio: false,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }

      ///Get minimum zooming level of camera controller
      _controller?.getMinZoomLevel().then((value) {
        zoomLevel = value;
        minZoomLevel = value;
      });

      ///Get maximum zooming level of camera controller
      _controller?.getMaxZoomLevel().then((value) {
        maxZoomLevel = value;
      });

      ///Get image stream of camera controller
      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  ///Process input image which capture by camera controller and detect text from image
  Future<void> processImage(InputImage inputImage) async {
    setState(() {});
    if (isBusy) return;
    isBusy = true;

    ///Recognised text from input image
    var recognisedText = await textDetector.processImage(inputImage);
    setState(() {
      widget.onGetDetectedText(recognisedText.text);
      widget.languageCode = widget.languageCode;
    });

    ///Translation function for translated recognised text
    await translation(recognisedText.text, widget.languageCode);

    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  ///Translate the text from tecognised text and language code
  Future<void> translation(String processtext, String toLanguageCode) async {
    try {
      await translator.translate(processtext, to: toLanguageCode).then((value) {
        setState(() {
          temp = value;
          translatedText = temp.toString();
          widget.onGetTranslatedText(translatedText);
        });
      });
    } catch (e) {
      print(e);
    }
  }

  ///For stop capture image from camera controller
  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  ///Get camera image from camera controller and convert in to InputImage
  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[_cameraIndex];
    final imageRotation =
        InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;

    final inputImageFormat =
        InputImageFormatMethods.fromRawValue(image.format.raw) ??
            InputImageFormat.NV21;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    ///Pass input image and get recognised text from image
    processImage(inputImage);
  }
}
