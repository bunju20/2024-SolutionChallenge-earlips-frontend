import 'package:flutter/material.dart';

class SmallCard extends StatelessWidget {
  final int type;

  const SmallCard({super.key, required this.type});

  // type에 따라 name을 반환
  String get name {
    switch (type) {
      case 0:
        return '음소';
      case 1:
        return '단어';
      case 2:
        return '문장';
      case 3:
        return '문단';
      default:
        return '음소';
    }
  }

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
        name,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
