import 'dart:io';

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ImagePage extends StatefulWidget {
  ImagePage({required this.valueChoose});
  final String valueChoose;

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  GoogleTranslator translator = GoogleTranslator();
  String Userpost = "";
  File? selectedMedia;
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
          'Image',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF4B0082),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<MediaFile>? media = await GalleryPicker.pickMedia(
              context: context, singleMedia: true);
          if (media != null && media.isNotEmpty) {
            var data = await media.first.getFile();
            setState(() {
              selectedMedia = data;
            });
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF51087E),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageView(),
            _extractTextView(),
            ElevatedButton(
                onPressed: () {
                  translate();
                  launchUrlString(
                      'https://www.google.com/search?q=$Userpost&tbm=shop&hl=$code');
                },
                child: Icon(Icons.search))
          ],
        ),
      ),
      backgroundColor: Color(0xFF51087E),
    );
  }

  Widget _imageView() {
    if (selectedMedia == null) {
      return const Center(
        child: Text(
          "Pick an image for text recognition",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return Center(
      child: Image.file(
        selectedMedia!,
        width: 200,
      ),
    );
  }

  Widget _extractTextView() {
    if (selectedMedia == null) {
      return const Center(
        child: Text(
          "no text",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return FutureBuilder(
        future: _extractText(selectedMedia!),
        builder: (context, snapshot) {
          return Text(
            snapshot.data ?? "",
            style: const TextStyle(fontSize: 25, color: Colors.white),
          );
        });
  }

  Future<String?> _extractText(File file) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    Userpost = recognizedText.text;
    textRecognizer.close();
    return Userpost;
  }
}
