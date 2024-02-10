import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AudioPage extends StatefulWidget {
  AudioPage({required this.valueChoose});
  final String valueChoose;

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  GoogleTranslator translator = GoogleTranslator();
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;
  String Userpost = "";
  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    _isListening = await _speech.initialize();
    setState(() {});
  }

  void _startListening() async {
    String code = widget.valueChoose;
    await _speech.listen(onResult: _onSpeechResult, localeId: '$code');
    setState(() {});
  }

  void _stopListening() async {
    await _speech.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      Userpost = "${result.recognizedWords}";
    });
  }

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
          'Audio',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF4B0082),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(100),
            child: Center(
              child: Text(
                _speech.isListening
                    ? "listening..."
                    : _isListening
                        ? "Tap the microphone"
                        : "speech not available",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            child: Text(Userpost),
          ),
          ElevatedButton(
            onPressed: () {
              translate();
              launchUrlString(
                  'https://www.google.com/search?q=$Userpost&tbm=shop&hl=$code');
            },
            child: Icon(Icons.search),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _speech.isListening ? _stopListening : _startListening,
        tooltip: 'Listen',
        child: Icon(
          _speech.isNotListening ? Icons.mic_off : Icons.mic,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF51087E),
      ),
      backgroundColor: Color(0xFF51087E),
    );
  }
}
