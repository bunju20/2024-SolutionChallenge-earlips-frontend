import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  // Observable 변수 정의
  var speakingScore = 98.obs;
  var pitchScore = 70.obs;
  var circleNumber = 42.obs;
  var linialPersent = 0.9.obs;

  // 발음 점수 업데이트
  void updateSpeakingScore(int newScore) {
    speakingScore.value = newScore;
  }

  // 높낮이 점수 업데이트
  void updatePitchScore(int newScore) {
    pitchScore.value = newScore;
  }

  // 원 안의 숫자 업데이트
  void updateCircleNumber(int newNumber) {
    circleNumber.value = newNumber;
  }

  // 선형 퍼센트 업데이트
  void updateLinialPersent(double newPersent) {
    linialPersent.value = newPersent;
  }
}

