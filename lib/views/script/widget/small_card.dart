import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallCard extends StatelessWidget {
  final String text;

  const SmallCard({super.key, required this.text});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: const Color(0xFF1FA9DC),
      ),
      alignment: Alignment.center,
      width: 50,
      height: 24,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
