import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudyCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final VoidCallback onTap;
  final double imgSize;

  const StudyCardWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.imagePath,
      required this.onTap,
      required this.imgSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.21,
      width: Get.width * 0.43,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              width: imgSize + 5,
              height: 90,
              child: Image.asset(
                imagePath,
                width: imgSize,
                height: imgSize,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Pretendard-Bold',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontFamily: 'Pretendard-Regular',
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
