import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ko_KR': {
          'title': '제목',
          'login': '로그인',
          'signup': '회원가입',
          'email': '이메일',
          'password': '비밀번호',
          'forgot_password': '비밀번호를 잊으셨나요?',
          'message1': "발음 연습해볼까요? 오늘도 화이팅!",
          'message2': "오늘은 어떤 단어를 배워볼까요?",
          'message3': "오늘도 화이팅!",
          'message4': "꾸준함이 능력! 꾸준히 노력하자!",
          'homeLanguage': '한국어',
          'homeHeaderGuest': '로그인이 필요합니다'
        },
        'en_US': {'title': 'title'},
      };
}
