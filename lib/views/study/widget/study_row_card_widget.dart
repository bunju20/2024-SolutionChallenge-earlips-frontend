import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class SmallCard extends StatelessWidget {
  final int type;

  const SmallCard({super.key, required this.type});

  // type에 따라 name을 반환
  String get name {
    switch (type) {
      case 0:
        return 'row_card_badge_1'.tr;
      case 1:
        return 'row_card_badge_2'.tr;
      case 2:
        return 'row_card_badge_3'.tr;
      case 3:
        return 'row_card_badge_4'.tr;
      default:
        return 'row_card_badge_1'.tr;
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
