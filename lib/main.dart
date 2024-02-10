import 'package:flutter/material.dart';
import 'input_page.dart';

void main() {
  runApp(const BuildForBharat());
}

class BuildForBharat extends StatelessWidget {
  const BuildForBharat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InputPage(),
    );
  }
}
