import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:realtime_translation/realtime_translation.dart';
import 'package:realtime_translation/views/bottom_language_view.dart';
import 'package:realtime_translation/views/camera_view.dart';

Future<void> main() async {
  await RealtimeTranslation().cameraInitialization();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: RealTimeTranslationView());
  }
}

class RealTimeTranslationView extends StatefulWidget {
  const RealTimeTranslationView({Key? key}) : super(key: key);

  @override
  _RealTimeTranslationViewState createState() =>
      _RealTimeTranslationViewState();
}

class _RealTimeTranslationViewState extends State<RealTimeTranslationView> {
  ///Set languages code list
  final List<String> languageCodeList = [
    'af',
    'sq',
    'am',
    'ar',
    'hy',
    'az',
    'eu',
    'be',
    'bn',
    'bs',
    'bg',
    'ca',
    'ceb',
    'ny',
    'zh-cn',
    'zh-tw',
    'co',
    'hr',
    'cs',
    'da',
    'nl',
    'en',
    'eo',
    'et',
    'tl',
    'fi',
    'fr',
    'fy',
    'gl',
    'ka',
    'de',
    'el',
    'gu',
    'ht',
    'ha',
    'haw',
    'iw',
    'he',
    'hi',
    'hmn',
    'hu',
    'is',
    'ig',
    'id',
    'ga',
    'it',
    'ja',
    'jw',
    'kn',
    'kk',
    'km',
    'ko',
    'ku',
    'ky',
    'lo',
    'la',
    'lv',
    'lt',
    'lb',
    'mk',
    'mg',
    'ms',
    'ml',
    'mt',
    'mi',
    'mr',
    'mn',
    'my',
    'ne',
    'no',
    'or',
    'ps',
    'fa',
    'pl',
    'pt',
    'pa',
    'ro',
    'ru',
    'sm',
    'gd',
    'sr',
    'st',
    'sn',
    'sd',
    'si',
    'sk',
    'sl',
    'so',
    'es',
    'su',
    'sw',
    'sv',
    'tg',
    'ta',
    'te',
    'th',
    'tr',
    'uk',
    'ur',
    'ug',
    'uz',
    'vi',
    'cy',
    'xh',
    'yi',
    'yo',
    'zu'
  ];

  ///Set languages name list
  final List<String> langNameList = [
    'afrikaans',
    'albanian',
    'amharic',
    'arabic',
    'armenian',
    'azerbaijani',
    'basque',
    'belarusian',
    'bengali',
    'bosnian',
    'bulgarian',
    'catalan',
    'cebuano',
    'chichewa',
    'chinese (simplified)',
    'chinese (traditional)',
    'corsican',
    'croatian',
    'czech',
    'danish',
    'dutch',
    'english',
    'esperanto',
    'estonian',
    'filipino',
    'finnish',
    'french',
    'frisian',
    'galician',
    'georgian',
    'german',
    'greek',
    'gujarati',
    'haitian creole',
    'hausa',
    'hawaiian',
    'hebrew',
    'hebrew',
    'hindi',
    'hmong',
    'hungarian',
    'icelandic',
    'igbo',
    'indonesian',
    'irish',
    'italian',
    'japanese',
    'javanese',
    'kannada',
    'kazakh',
    'khmer',
    'korean',
    'kurdish (kurmanji)',
    'kyrgyz',
    'lao',
    'latin',
    'latvian',
    'lithuanian',
    'luxembourgish',
    'macedonian',
    'malagasy',
    'malay',
    'malayalam',
    'maltese',
    'maori',
    'marathi',
    'mongolian',
    'myanmar (burmese)',
    'nepali',
    'norwegian',
    'odia',
    'pashto',
    'persian',
    'polish',
    'portuguese',
    'punjabi',
    'romanian',
    'russian',
    'samoan',
    'scots gaelic',
    'serbian',
    'sesotho',
    'shona',
    'sindhi',
    'sinhala',
    'slovak',
    'slovenian',
    'somali',
    'spanish',
    'sundanese',
    'swahili',
    'swedish',
    'tajik',
    'tamil',
    'telugu',
    'thai',
    'turkish',
    'ukrainian',
    'urdu',
    'uyghur',
    'uzbek',
    'vietnamese',
    'welsh',
    'xhosa',
    'yiddish',
    'yoruba',
    'zulu'
  ];

  ///Get select language code
  String lanCode = "gu";

  ///Get select language name
  String lanName = "gujarati";

  ///Get translated text
  String transText = "";

  ///Get detected text
  String detectText = "";

  ///Get screen width
  double mWidth = 0;

  ///Get screen height
  double mHeight = 0;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
            width: mWidth,
            height: mHeight,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            width: mWidth,
                            height: mHeight,
                            decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.black),
                            ),

                            ///TsCameraView for detect text
                            child: TsCameraView(
                              ///select language code
                              languageCode: lanCode,

                              ///Callback of detected text
                              onGetDetectedText: (String detectGetText) {
                                setState(() {
                                  detectText = detectGetText;
                                });
                              },

                              ///Callback of translated text
                              onGetTranslatedText: (String translateGetText) {
                                setState(() {
                                  transText = translateGetText;
                                });
                              },
                            )),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,

                          ///Select language,detected text and translated text view
                          child: DetectionLanguageView(
                            ///Languages code list
                            languagesCodeList: languageCodeList,

                            ///Select language name
                            toLanguageName: lanName,

                            ///Languages name list
                            languagesList: langNameList,

                            ///Select language code
                            toLangugeCode: lanCode,

                            ///Callback of get language code and name
                            selectLanguageData:
                                (String languageCode, String languageName) {
                              lanCode = languageCode;
                              lanName = languageName;
                            },

                            ///For display translated text
                            translatedText: transText,

                            ///For display detected text
                            detectedText: detectText,
                          )),
                    ],
                  ),
                ),
              ],
            )));
  }
}
