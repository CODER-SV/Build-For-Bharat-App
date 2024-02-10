import 'package:build_for_bharat/reusableCard.dart';
import 'package:flutter/material.dart';
import 'text.dart';
import 'audio.dart';
import 'image.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String valueChoose = "";
  List listItem = [
    {"language": 'English', "code": 'en'},
    {"language": 'हिन्दी', "code": 'hi'},
    {"language": 'বাংলা', "code": 'bn'},
    {"language": 'తెలుగు', "code": 'te'},
    {"language": 'ગુજરાતી', "code": 'gu'},
    {"language": 'ਪੰਜਾਬੀ', "code": 'pa'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF51087E),
      appBar: AppBar(
        title: Text(
          'PROJECT',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF4B0082),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: DropdownButton<String>(
              value: valueChoose,
              items: [
                const DropdownMenuItem(
                    child: Text(
                      'Choose Language:',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: ""),
                ...listItem.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem(
                      child: Text(
                        e['language'],
                        style: TextStyle(color: Colors.white),
                      ),
                      value: e['code']);
                }).toList(),
              ],
              dropdownColor: Color(0xFF8F0FF),
              onChanged: (newValue) {
                setState(() {
                  valueChoose = newValue!;
                });
                print("selected $valueChoose");
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TextPage(
                      valueChoose: valueChoose,
                    ),
                  ),
                );
              },
              child: ReusableCard(
                label: 'Text',
                icon: Icons.message,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AudioPage(
                      valueChoose: valueChoose,
                    ),
                  ),
                );
              },
              child: ReusableCard(
                label: 'Audio',
                icon: Icons.mic,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImagePage(
                        valueChoose: valueChoose,
                      ),
                    ),
                  );
                },
                child: ReusableCard(
                  label: 'Image',
                  icon: Icons.image,
                )),
          )
        ],
      ),
    );
  }
}
