# realtime_translation

## Getting Started

A flutter plugin for Andoid and ios for make real time translation of text from camera. This plugin through you can select language 
and then TsCameraView thorugh you can detect text and see translation of detected text and also set zooming level for camera.

#Setup for Android

Add these lines in your AndroidManifest.xml file and change the minimum Android sdk version to 21 (or higher) in your `android/app/build.gradle` file.

```
minSdkVersion 21
```

```xml
<uses-feature android:name="android.hardware.camera" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" />
```

#Setup for iOS

The realtime_translation plugin functionality works on iOS 10.0 or higher. If compiling for any version lower than 10.0,
make sure to programmatically check the version of iOS running on the device before using any realtime_translation plugin features.
The [device_info_plus](https://pub.dev/packages/device_info_plus) plugin, for example, can be used to check the iOS version.

Add two rows to the `ios/Runner/Info.plist`:

* one with the key `Privacy - Camera Usage Description` and a usage description.

Or in text format add the key:

```xml
<key>NSCameraUsageDescription</key>
<string>Can I use the camera for capture image and recognised text?</string>
```

#Add TsCameraView for detect text

```dart
TsCameraView(
languageCode: lanCode,
onGetDetectedText: (String detectGetText) {
setState(() {
detectText = detectGetText;
});
},
onGetTranslatedText: (String translateGetText) {
setState(() {
transText = translateGetText;
});
},
)
```

#Add DetectionLanguageView for select languge and shown detect and translated text

```dart
DetectionLanguageView(
languagesCodeList: languageCodeList,
toLanguageName: lanName,
languagesList: langNameList,
toLangugeCode: lanCode,
selectLanguageData:
(String languageCode, String languageName) {
lanCode = languageCode;
lanName = languageName;
},
translatedText: transText,
detectedText: detectText,
)
```

#Preview of Real Time Translation
![](https://github.com/kesmitopiwala/realtime_translation/blob/master/assets/realtime_translation.gif)

| -------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| ![](https://github.com/kesmitopiwala/realtime_translation/blob/master/assets/ss1.png) | ![](https://github.com/kesmitopiwala/realtime_translation/blob/master/assets/ss2.png) |

| -------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| ![](https://github.com/kesmitopiwala/realtime_translation/blob/master/assets/ss3.png) | ![](https://github.com/kesmitopiwala/realtime_translation/blob/master/assets/ss4.png) |

| -------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| ![](https://github.com/kesmitopiwala/realtime_translation/blob/master/assets/ss5.png) |                                                                              |