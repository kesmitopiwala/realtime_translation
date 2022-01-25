import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

///Callback of get select language code and name
typedef SelectLanguage = void Function(
    String languageCode, String languageName);

///Detection language view where manage view of choose language and get detected & translated text
class DetectionLanguageView extends StatefulWidget {
  DetectionLanguageView(
      {Key? key,
      required this.toLanguageName,
      required this.toLangugeCode,
      required this.languagesList,
      required this.languagesCodeList,
      required this.detectedText,
      required this.translatedText,
      required this.selectLanguageData})
      : super(key: key);

  ///Select language name
  String toLanguageName;

  ///Get select language code
  String toLangugeCode;

  ///Get languages list
  List<String> languagesList;

  ///Get languages code list
  List<String> languagesCodeList;

  ///Get detected text
  String detectedText;

  ///Get translated text
  String translatedText;

  ///Get callback of select lanaguge name and code
  SelectLanguage selectLanguageData;

  @override
  _DetectionLanguageViewState createState() => _DetectionLanguageViewState();
}

class _DetectionLanguageViewState extends State<DetectionLanguageView> {
  ///Get select language name through get language code
  void langNametolangCode() {
    for (int i = 0; i < widget.languagesList.length; i++) {
      if (widget.languagesList[i] == widget.toLanguageName) {
        widget.toLangugeCode = widget.languagesCodeList[i];
      }
    }
  }

  @override
  void initState() {
    super.initState();

    ///Select default lanaguge shown
    langNametolangCode();
    widget.selectLanguageData(widget.toLangugeCode, widget.toLanguageName);
  }

  @override
  Widget build(BuildContext context) {
    ///View of detect language view
    return Container(
      height: MediaQuery.of(context).size.height * 0.34,
      width: MediaQuery.of(context).size.width * 0.91,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.only(bottom: 26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Detected Text ',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),

                ///Display dropdownsearch for select langauge
                Expanded(
                  child: Container(
                      height: 50,
                      // width: 100,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 3),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: DropdownSearch<String>(
                        maxHeight: 300,
                        label: widget.toLanguageName,
                        selectedItem: widget.toLanguageName,
                        showSelectedItems: true,
                        hint: "Choose Language Of Translation",
                        items: widget.languagesList,
                        showSearchBox: true,
                        dropdownSearchBaseStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                        dropdownSearchDecoration: const InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            labelText: "Search"),
                        onChanged: (value) {
                          setState(() {
                            widget.toLanguageName = value!;
                            langNametolangCode();
                            widget.selectLanguageData(
                                widget.toLangugeCode, widget.toLanguageName);
                          });
                        },
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          ),

          ///Display detected text
          Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(6.0),
              margin: const EdgeInsets.only(left: 22, right: 22),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(12.0)),
              child: SingleChildScrollView(
                  child: Text(
                widget.detectedText,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ))),
          const SizedBox(
            height: 4,
          ),
          Container(
            margin: const EdgeInsets.only(left: 12),
            child: Row(
              children: const [
                SizedBox(
                  width: 10,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Translated Text ',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          ),

          ///Display translated text
          Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(6.0),
              margin: const EdgeInsets.only(left: 22, right: 22),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(12.0)),
              child: SingleChildScrollView(
                  child: Text(
                widget.translatedText,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ))),
        ],
      ),
    );
  }
}
