import 'package:build_for_bharat/constants.dart';
import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 100.0,
            color: Colors.white,
          ),
          Text(
            label,
            style: kLabelTextStyle,
          ),
        ],
      ),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFF8F0FF),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
