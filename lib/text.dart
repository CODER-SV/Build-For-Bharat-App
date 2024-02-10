import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TextPage extends StatefulWidget {
  TextPage({required this.valueChoose});
  final String valueChoose;

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  GoogleTranslator translator = GoogleTranslator();
  final _textController = TextEditingController();
  String Userpost = "";
  void translate() {
    translator.translate(Userpost, to: "en").then((output) {
      setState(() {
        Userpost = output.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String code = widget.valueChoose;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Text',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF4B0082),
      ),
      body: Center(
        child: TextField(
          controller: _textController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: () {
                Userpost = _textController.text;
                translate();
                launchUrlString(
                    'https://www.google.com/search?q=$Userpost&tbm=shop&hl=$code');
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Color(0xFF51087E),
    );
  }
}
