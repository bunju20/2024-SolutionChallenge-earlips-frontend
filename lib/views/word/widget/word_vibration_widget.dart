import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';


class WordVibrationWidget extends StatelessWidget {
  const WordVibrationWidget({super.key, this.pattern, this.intensities});

final List<int>? pattern;
final List<int>? intensities;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(top: 10),
      //정렬,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      child: Container(
                        width: Get.width * 0.33,
                        child: Row(
                          children: [
                            Text('진동으로 들어보기'),
                            const SizedBox(width: 10),
                        Icon(Icons.vibration),
                          ],
                        ),
                      ),
                      onPressed: () {
                        Vibration.vibrate(
                          pattern: [50, 1000, 10, 2000, 500, 3000, 500, 500],
                          intensities: [0, 128, 0, 255, 0, 64, 0, 255],
                        );
                      },
                    ),
                  ],
                ),
    );
  }
}
